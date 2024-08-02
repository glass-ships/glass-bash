#! /usr/bin/env bash
DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

####################
### Boring stuff ###
####################

# This section may not be necessary, as most of it already exists
# in the default .bashrc file. I'm keeping it here for reference for now.

# # If not running interactively, don't do anything
# case $- in
# *i*) ;;
# *) return ;;
# esac

# # No duplicate lines or lines starting with space in history. See bash(1) for more options
# HISTCONTROL=ignoreboth

# # Set history length. See HISTSIZE and HISTFILESIZE in bash(1)
# HISTSIZE=1000
# HISTFILESIZE=2000

# # Make less more friendly for non-text input files, see lesspipe(1)
# [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# # Enable color support of ls and also add handy aliases
# if [ -x /usr/bin/dircolors ]; then
# 	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
# 	alias dir='dir --color=auto'
# 	alias vdir='vdir --color=auto'
# fi

# # Colored GCC warnings and errors
# export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# # Enable programmable completion features
# # (you don't need to enable this, if it's already enabled
# # in /etc/bash.bashrc, as /etc/profile sources /etc/bash.bashrc).
# if ! shopt -oq posix; then
# 	if [ -f /usr/share/bash-completion/bash_completion ]; then
# 		. /usr/share/bash-completion/bash_completion
# 	elif [ -f /etc/bash_completion ]; then
# 		. /etc/bash_completion
# 	fi
# fi

#########################
### Environment Setup ###
#########################

export XDG_CONFIG_HOME="$HOME/.config"

if [ -f $DIR/secrets.sh ]; then
	echo "Secrets file exists."
else
	echo "No secrets file found."
fi

#-----------#
# Git stuff #
#-----------#

# Get current branch in git repo
function parse_git_branch() {
	BRANCH=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
	if [ ! "${BRANCH}" == "" ]; then
		STAT=$(parse_git_dirty)
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# Get current status of git repo
function parse_git_dirty {
	status=$(git status 2>&1 | tee)
	dirty=$(
		echo -n "${status}" 2>/dev/null | grep "modified:" &>/dev/null
		echo "$?"
	)
	untracked=$(
		echo -n "${status}" 2>/dev/null | grep "Untracked files" &>/dev/null
		echo "$?"
	)
	ahead=$(
		echo -n "${status}" 2>/dev/null | grep "Your branch is ahead of" &>/dev/null
		echo "$?"
	)
	newfile=$(
		echo -n "${status}" 2>/dev/null | grep "new file:" &>/dev/null
		echo "$?"
	)
	renamed=$(
		echo -n "${status}" 2>/dev/null | grep "renamed:" &>/dev/null
		echo "$?"
	)
	deleted=$(
		echo -n "${status}" 2>/dev/null | grep "deleted:" &>/dev/null
		echo "$?"
	)
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

##################
### Cool stuff ###
##################

#----------------------#
# Customize cmd prompt #
#----------------------#

# Colors (to change colors, change "AAA" in "\e[38;5;AAAm\]")
cRed="\[\e[0;31m\]"
cPurp="\[\e[38;5;62m\]"
cYel="\[\e[38;5;221m\]"
cPink="\[\e[38;5;201m\]"
cCyan="\[\e[38;5;87m\]"
cWhite="\[\e[38;5;255m\]"
# c0="\[\e[0;31m\]"     # red
# c1="\[\e[38;5;62m\]"  # purple (alt use 35m)
# c2="\[\e[38;5;221m\]" # yellow (alt use 33m)
# c3="\[\e[38;5;201m\]" # pink
# c4="\[\e[38;5;87m\]"  # cyan (alt use 36m)

# Prompt
pTIME="\[$cYel\][\[$cPurp\]\t\[$cYel\]]\[\e[m\]"
pWHO="\[$cCyan\]\[\u\]\[$cPink\]@\[$cCyan\]\[\h\]\[\e[m\]"
# pGIT="\[$cPink\]\[\`parse_git_dirty\`\] "
pGIT=" \[$cPink\]\[\`parse_git_branch\`\]"
pDIR="\[$cCyan\]\[\w\]\[$cPink\]$pGIT\[\e[m\]"
PS1="\[\n\]$pTIME $pDIR\[\n\]$pWHO $cYel$ $cWhite"

# Backup option in case of issues with the above prompt
# PS1="\[\n\]\[\033[38;5;57m\][\[$(tput sgr0)\]\[\033[38;5;226m\]\A\[$(tput sgr0)\]\[\033[38;5;57m\]]\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;14m\]\w\[$(tput sgr0)\]\n\[$(tput sgr0)\]\[\033[38;5;213m\]\u\[$(tput sgr0)\]\[\033[38;5;226m\]@\[$(tput sgr0)\]\[\033[38;5;141m\]\h\[$(tput sgr0)\] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;11m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"

#---------------------------------------#
# Force CLI credentials for git and ssh #
#---------------------------------------#
unset SSH_ASKPASS
unset GIT_ASKPASS

#---------------------#
# Source custom stuff #
#---------------------#
for file in $DIR/scripts/*.sh; do
	source $file
done

#--------------#
# Extra config #
#--------------#

if command -v direnv &>/dev/null; then
	eval "$(direnv hook bash)"
fi

if command -v starship &>/dev/null; then
	eval "$(starship init bash)"
fi

if [ -f ~/.cargo/bin ]; then
	export PATH="$HOME/.cargo/bin:$PATH"
	. "$HOME/.cargo/env"
fi

########################################################################################
unset DIR

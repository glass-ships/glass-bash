#! /usr/bin/env bash
DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

#####################
###  Options etc. ###
#####################

# Force cmdline password entry for ssh and git
unset SSH_ASKPASS
unset GIT_ASKPASS

umask 022

#########################
### Environment Setup ###
#########################

export GDK_BACKEND=wayland,x11
export XDG_CONFIG_HOME="$HOME/.config"

#----------------------------------------#
# Source secrets as env vars, if present #
#----------------------------------------#

if [ -f $DIR/secrets.json ] || [ -L $DIR/secrets.json ]; then
	# echo "Secrets file exists."
	while IFS= read -r line; do
		if [[ $line == "{" || $line == "}" ]]; then
			continue
		fi
		key=$(echo $line | cut -d':' -f1 | tr -d '"' | tr -d ' ')
		value=$(echo $line | cut -d':' -f2- | tr -d "," | tr -d ' ')
		export $key=$value
	done <$DIR/secrets.json
else
	# echo "No secrets file found."
	:
fi

#-----------------------------------#
# Conda / Mamba checks and settings #
#-----------------------------------#

# ...

#------------------------#
# Python/Poetry settings #
#------------------------#
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring
export POETRY_HOME=/opt/poetry
if [ -d /opt/poetry/bin ]; then
	export PATH=/opt/poetry/bin:$PATH
	poetry config virtualenvs.in-project true
fi
unset VIRTUAL_ENV
unset VIRTUAL_ENV_PROMPT

#----------------#
# pyenv settings #
#----------------#
if [ -d ~/dev/.pyenv ]; then
	export PYENV_ROOT=~/dev/.pyenv
	export PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
	pyenv init - | source
fi

####################################
### Custom Aliases and Functions ###
####################################

for file in $DIR/scripts/*.sh; do
	source $file
done

####################################
### Additional Configs and Paths ###
####################################

if command -v direnv &>/dev/null; then
	eval "$(direnv hook bash)"
fi

if command -v starship &>/dev/null; then
	eval "$(starship init bash)"
fi

# if [ -f ~/.cargo/bin ]; then
if [ -d ~/.cargo/bin ]; then
	export PATH="$HOME/.cargo/bin:$PATH"
	. "$HOME/.cargo/env"
fi

export BUN_INSTALL="$HOME/.bun/"
if [ -d $BUN_INSTALL ]; then
	export PATH="$BUN_INSTALL/bin:$PATH"
fi

########################################################################################
unset DIR

####################
### Boring stuff ###
####################
###
### This section may not be necessary, as most of it already exists
### in the default .bashrc file. I'm keeping it here for reference for now.
###

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

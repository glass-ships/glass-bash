#####################
### Custom Prompt ###
#####################

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

# Get colorized exit code
function parse_exit_code() {
	EXIT_CODE=$?
	if [ $EXIT_CODE -eq 0 ]; then
		echo -e "\e[0;32m"
	else
		echo -e "\e[0;31m"
	fi
}

#----------------------#
# Customize cmd prompt #
#----------------------#

# Colors (to change colors, change "AAA" in "\e[38;5;AAAm\]")
RED="\[\e[0;31m\]"
PURPLE="\[\e[38;5;62m\]"  # (alt use 35m)
YELLOW="\[\e[38;5;221m\]" # (alt use 33m)
PINK="\[\e[38;5;201m\]"
CYAN="\[\e[38;5;87m\]" # (alt use 36m)
WHITE="\[\e[38;5;255m\]"
RESTORE="\[\033[0m\]" # 0m restores to the terminal's default colour

# Prompt
pTIME="$YELLOW[$PURPLE\D{%Y-%m-%d %H:%M:%S}$YELLOW]\[$(tput sgr0)\]"
pDIR="$CYAN\w$PINK\[$(tput sgr0)\]"
pGIT=" $PINK\`parse_git_branch\`\[$(tput sgr0)\]"
pWHO="$CYAN\u$PINK@$CYAN\h\[$(tput sgr0)\]"
PS1="\n$pTIME $pDIR $pGIT\n\[\`parse_exit_code\`\]\$? $pWHO $YELLOW\$ $RESTORE"

# Backup option in case of issues with the above prompt
# PS1="\[\n\]\[\033[38;5;57m\][\[$(tput sgr0)\]\[\033[38;5;226m\]\A\[$(tput sgr0)\]\[\033[38;5;57m\]]\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;14m\]\w\[$(tput sgr0)\]\n\[$(tput sgr0)\]\[\033[38;5;213m\]\u\[$(tput sgr0)\]\[\033[38;5;226m\]@\[$(tput sgr0)\]\[\033[38;5;141m\]\h\[$(tput sgr0)\] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;11m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"

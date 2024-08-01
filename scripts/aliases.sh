#!/usr/bin/env bash

#---------#
# General #
#---------#

alias ll='ls -al1vF'
alias env='env | sort'               # sorted env
alias grep='grep -n'                 # always grep with line numbers
alias pls='sudo -E '                 # sudo with user PATH
alias sfind='sudo find / -name '$@'' # search entire filesystem for a value
alias howbig='du -csh '$@''          # check how big a directory is
alias upd='sudo apt update -y && sudo apt full-upgrade -y'

### Directory Navigation ###

alias l='ls -CF --color=auto'
alias la='ls -A --color=auto'
alias ll='ls -alF --color=auto'

alias dev='cd ~/dev'
alias -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

#-----#
# Git #
#-----#

alias gs='git status'
alias gco='git checkout'
alias gadd='git add -A'
alias gcam='git commit -am'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gstash='git stash'
alias gpop='git stash pop'
alias gsl='git stash list'
alias grpo='git remote prune origin'

#--------------------#
# Python/Conda stuff #
#--------------------#

alias c='conda'
alias cenv='conda env list'
alias cact='conda activate'

#-----#
# SSH #
#-----#

#alias ssh='ssh -X'
alias sshpipe='ssh -L 8888:localhost:8888'

#--------#
# Extras #
#--------#

alias jlab='jupyter-lab --no-browser'

#!/usr/bin/env bash

#---------#
# General #
#---------#

# Add an "alert" alias for long running commands.  Use like so:
# $ sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias env='env | sort'               # sorted env
alias grep='grep -n'                 # always grep with line numbers
alias howbig='du -csh '$@''          # check how big a directory is
alias pls='sudo -E '                 # sudo with user PATH
alias res='echo $?'                  # echo the last command's exit status
alias sfind='sudo find / -name '$@'' # search entire filesystem for a value
alias upd='sudo apt update -y && sudo apt full-upgrade -y'

#------------#
# Navigation #
#------------#

alias ll='ls -al1vF --color=auto'
alias dev='cd ~/dev'
alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

#---------------------#
# Python/Poetry/Conda #
#---------------------#

alias wpy='which python'
alias pyver='python --version'

alias c='conda'
alias cenv='conda env list'
alias cact='conda activate'

alias poetry-clear='poetry cache clear _default_cache --all && poetry cache clear PyPI --all'
alias jlab='jupyter lab --no-browser' # start jupyter lab

#-----#
# Git #
#-----#

alias gs='git status'
alias gss='git status -sb'
alias glog='git log --oneline --graph --decorate --all'

alias gsb='git switch'
alias gco='git checkout'
alias gpull='git pull'
alias gadd='git add -A'
alias gcam='git commit -am'
alias gba='git branch -a'
alias gbd='git branch -d'

alias gstash='git stash'
alias gspop='git stash pop'
alias gsl='git stash list'
alias grpo='git remote prune origin'

#--------#
# Docker #
#--------#

alias docker-cleanup='docker rmi (docker images -f "dangling=true" -q)'
alias docker-rm-containers='docker rm (docker ps -a -q)'

#-----#
# GCP #
#-----#

alias gcssh='gcloud compute ssh'

#------#
# Misc #
#------#

alias get-spotify-playlists="cd ~/dev/spotipy-stuff && poetry -C ~/dev/DISCORD/compass-bot run python scripts/download_spotify_playlists.py -u oceanblocker && cd -"
alias install-rust="curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
alias vscode='/mnt/d/Programs/Google\ Drive/Apps/VSCode/bin/code'
alias ssh-compass='ssh root@157.230.224.73'
alias update-compass='cd ~/compass-bot/ && poetry run compass stop && git pull && poetry run compass -v start'

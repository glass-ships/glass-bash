#!/usr/bin/env bash

###########
# General #
###########

alias env='env | sort'               # sorted env
alias grep='grep -n'                 # always grep with line numbers
alias howbig='du -csh '$@''          # check how big a directory is
alias pls='sudo -E '                 # sudo with user PATH
alias res='echo $?'                  # echo the last command's exit status
alias sfind='sudo find / -name '$@'' # search entire filesystem for a value
alias upd='sudo apt update -y && sudo apt full-upgrade -y'

##############
# Navigation #
##############

alias ll='ls -al1vF --color=auto'
alias dev='cd ~/dev'
alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

##########
# Python #
##########

alias wpy='which python'
alias pyver='python --version'
alias mm='micromamba'
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

##########
# Docker #
##########

alias docker-cleanup='docker rmi (docker images -f "dangling=true" -q)'
alias docker-rm-containers='docker rm (docker ps -a -q)'

#######
# GCP #
#######

# alias gcssh='gcloud compute ssh'

########
# Misc #
########

alias install-bun="curl -fsSL https://bun.sh/install | bash"
alias install-micromamba="curl -L micro.mamba.pm/install.sh | bash"
alias install-pixi="curl -fsSL https://pixi.sh/install.sh | bash"
alias install-rust="curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
alias install-uv="curl -fsSL https://astral.sh/uv/install.sh | sh"

alias get-spotify-playlists="bash /d/dev/_scripts/src/spotify-stuff/download_spotify_playlists.py"

alias ssh-compass='ssh root@174.138.108.38'
alias update-compass='cd ~/compass-bot/ && uv run compass stop && git pull && uv run compass -v start'

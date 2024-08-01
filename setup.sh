#! /usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
echo Script directory: $DIR

# Add source env to bashrc (unless it's already there somehow)
echo -e '\nInstalling glass-bash...\n'
grep -qxF 'source '$DIR'/main' $HOME/.bashrc || echo 'source '$DIR'/main' >>$HOME/.bashrc

# VIM settings
echo -e '\nCopying VIM settings...\n'
cp ./.vimrc $HOME/.vimrc

# Make sure an SSH key exists
echo -e '\nChecking for SSH key...\n'
if [ ! -e $HOME/.ssh ]; then
    echo -e '\nCreating SSH key...\n'
    ssh-keygen -t rsa
else
    echo -e '\n\e[95mNOTICE\e[0m: ssh key already exists.'
fi

# Set git user info
echo -e '\nSetting Git user info...\n'
read -p 'Please enter your Git username: ' gituser
read -p 'Please enter your Git email: ' gitemail
git config --global user.name "$gituser"
git config --global user.email "$gitemail"

# Set git to globally ignore ipynb_checkpoints
echo -e '\nSetting Git default ignores...\n'
git config --global core.excludesfile '~/.gitignore'
echo '.ipynb_checkpoints' >>~/.gitignore
echo '*/.ipynb_checkpoints' >>~/.gitignore

# Set default name for new git repos
git config --global init.defaultBranch main

############################################
echo -e '\nglass-bash setup is complete!\n'

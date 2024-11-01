#! /usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
echo Script directory: $DIR

# Add source env to bashrc (unless it's already there somehow)
echo -e '\nInstalling glass-bash...'
grep -qxF 'source '$DIR'/main.sh' $HOME/.bashrc || echo 'source '$DIR'/main.sh' >>$HOME/.bashrc

# Make sure an SSH key exists
echo -e '\nChecking for SSH key...'
if [ ! -e $HOME/.ssh ]; then
    echo -e '\nCreating SSH key...'
    ssh-keygen -t rsa
else
    echo -e '\n\e[95mNOTICE\e[0m: ssh key already exists.'
fi

# Set git user info, if not already set
echo -e '\nSetting Git user info...'
if [ -z "$(git config --global user.name)" ]; then
    read -p 'Please enter your Git username: ' gituser
    git config --global user.name "$gituser"
else
    echo -e '\n\e[95mNOTICE\e[0m: Git user info already set.'
fi

if [ -z "$(git config --global user.email)" ]; then
    read -p 'Please enter your Git email: ' gitemail
    git config --global user.email "$gitemail"
else
    echo -e '\n\e[95mNOTICE\e[0m: Git email already set.'
fi

############################################
echo -e '\nglass-bash setup is complete!'

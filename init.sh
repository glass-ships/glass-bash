#! /usr/bin/env bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
echo Script directory: $DIR

# add source env to bashrc (unless it's already there somehow)
grep -qxF 'source '$DIR'/main' $HOME/.bashrc || echo 'source '$DIR'/main' >> $HOME/.bashrc

# VIM settings
cp ./vimrc $HOME/.vimrc

# make sure an SSH key exists, copy config
if [ ! -e $HOME/.ssh ]; then
    ssh-keygen -t rsa
    cp ./ssh-config $HOME/.ssh/config
elif [ -e $HOME/.ssh ]; then
    echo -e '\e[95mNOTICE\e[0m: ssh key already exists.'
fi

# Let config be visible by others
#chmod 644 $HOME/.ssh/config 

# set git name and email
git config --global user.name "glass"
git config --global user.email "glass.ships@outlook.com"

# set git to globally ignore ipynb_checkpoints
git config --global core.excludesfile '~/.gitignore'
echo '.ipynb_checkpoints' >> ~/.gitignore
echo '*/.ipynb_checkpoints' >> ~/.gitignore


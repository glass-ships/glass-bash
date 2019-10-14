#! /usr/bin/env bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
echo Script directory: $DIR

# add source env to bashrc
grep -qxF 'source '$DIR'/main' $HOME/.bashrc || echo 'source '$DIR'/main' >> $HOME/.bashrc

# VIM settings
cp ./vimrc $HOME/.vimrc

# ssh
if [ ! -e $HOME/.ssh ]; then
    ssh-keygen -t rsa
    cp ./ssh-config $HOME/.ssh/config
elif [ -e $HOME/.ssh ]; then
    echo -e '\e[95mNOTICE\e[0m: ssh key already exists.'
fi

chmod 644 $HOME/.ssh/config 

# set git name and email
git config --global user.name "glass"
git config --global user.email "glass.ships@outlook.com"

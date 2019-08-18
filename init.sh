#! /usr/bin/env bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
echo Script directory: $DIR

# add bashrc
cp ./bashrc $HOME/.bashrc
source $HOME/.bashrc

# add ssh settings
ssh-keygen -t rsa
cp ./ssh-config $HOME/.ssh/config
chmod 644 $HOME/.ssh/config 

# set git name and email
git config --global user.name "glass"
git config --global user.email "glass.ships@outlook.com"

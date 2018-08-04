# add bashrc
cp ./bashrc $HOME/.bashrc
source $HOME/.bashrc

# add ssh settings
cp ./sshconfig $HOME/.ssh/config
chmod 644 $HOME/.ssh/config 

# set git name and email
git config --global user.name "glass ships"
git config --global user.email "glass.ships@outlook.com"

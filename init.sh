# add bashrc
cp ./bashrc ~/.bashrc
source ~/.bashrc

# add ssh settings
cp ./sshconfig ~/.ssh/config
chmod 644 ~/.ssh/config 

# set git name and email
git config --global user.name "glass ships"
git config --global user.email "glass.ships@outlook.com"

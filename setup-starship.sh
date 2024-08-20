#/usr/bin/env bash

# Install a Nerd Font --> u can choose another at: https://www.nerdfonts.com/font-downloads
FONT=FiraCode
echo "[-] Download fonts [-]"
echo "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/$FONT.zip"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/$FONT.zip
mkdir -p ~/dev/_assets/fonts
unzip $FONT.zip -d ~/dev/_assets/fonts
fc-cache -fv ~/dev/_assets/fonts
rm $FONT.zip
echo "done!"

# Install Starship
echo "[-] Install Starship [-]"
curl -fsSL https://starship.rs/install.sh | bash

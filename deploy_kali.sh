#!/bin/bash

# Updating the system
sudo apt-get update -y && sudo apt-get upgrade -y

# Installing some necessary programs
sudo apt-get -y install neofetch feh gcc g++ htop libxft-dev libx11-dev libxinerama-dev flameshot keepassxc pavucontrol pcmanfm sxiv qbittorrent radare2 redshift unrar vim xserver-xorg xinit x11-utils libimage-exiftool-perl ltrace mpv ffuf zathura pandoc texlive-latex-recommended 

# Downloading and installing dwm
mkdir ~/.dwm && git clone https://github.com/p1xxxel/dwm ~/.dwm/dwm && cd ~/.dwm/dwm && sudo make clean install && cd ~

# Downloading and installing dmenu
mkdir ~/.dmenu && git clone https://github.com/p1xxxel/dmenu ~/.dmenu/dmenu && cd ~/.dmenu/dmenu && sudo make clean install && cd ~

# Downloading and installing slstatus
mkdir ~/.slstatus && git clone https://github.com/p1xxxel/slstatus ~/.slstatus/slstatus && cd ~/.slstatus/slstatus && sudo make clean install && cd ~

# Downloading and deploying dotfiles
git clone https://github.com/p1xxxel/dotfiles ~/Downloads/dotfiles && cd ~
mv ~/Downloads/dotfiles/.xinitrc ~/
mkdir -p .config/alacritty
mv ~/Downloads/dotfiles/alacritty.yml ~/.config/alacritty/
echo "#vi mode" >> ~/.bashrc
echo "set -o vi" >> ~/.bashrc
echo "#vi mode" >> ~/.zshrc
echo "set -o vi" >> ~/.zshrc
echo "set nu" >> ~/.vimrc
sudo mv ~/Downloads/dotfiles/profile /etc/profile
mv ~/Downloads/dotfiles/.fehbg ~/

# Downloading and installing font
cd ~ && wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip && unzip ~/Hack.zip && sudo mv ~/*ttf /usr/share/fonts/ && cd ~ && fc-cache
# Downloading and installing alacritty
cd ~/Downloads && wget https://github.com/alacritty/alacritty/releases/download/v0.4.2/Alacritty-v0.4.2-ubuntu_18_04_amd64.deb && sudo dpkg -i ~/Downloads/Alacritty* && sudo apt-get install -f && cd ~

# Downloading and installing discord
cd ~/Downloads && wget http://ftp.br.debian.org/debian/pool/main/liba/libappindicator/libappindicator1_0.4.92-7_amd64.deb && cd ~
cd ~/Downloads && wget http://ftp.br.debian.org/debian/pool/main/libi/libindicator/libindicator7_0.5.0-4_amd64.deb && cd ~
cd ~/Downloads && wget https://dl.discordapp.net/apps/linux/0.0.14/discord-0.0.14.deb && cd ~
sudo dpkg -i ~/Downloads/libindicator7* && sudo apt-get install -f && sudo dpkg -i ~/Downloads/libappindicator* && sudo apt-get install -f && sudo dpkg -i ~/Downloads/discord* && sudo apt-get install -f

# Downloading and installing ungoogled-chromium
cd ~/Downloads && wget https://github.com/LordTwix/ungoogled-chromium-binaries/releases/download/87.0.4280.141-1.1/ungoogled-chromium_87.0.4280.141-1.1_linux.AppImage && chmod +x ungoogled* && sudo mv ungoogled* /usr/bin/ungoogled-chromium && cd ~

# Installing python2 pip
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
sudo python2 get-pip.py
rm get-pip.py

# Installing some python libraries
sudo apt-get -y install python3-pip
pip3 install --user pwn
pip3 install --user gmpy2

# Cleaning up
sudo rm -rf ~/Downloads/dotfiles ~/Hack.zip ~/Downloads/Alacritty*


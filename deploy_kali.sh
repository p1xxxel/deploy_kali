#!/bin/bash

# Define colors...
RED=`tput bold && tput setaf 1`
GREEN=`tput bold && tput setaf 2`
YELLOW=`tput bold && tput setaf 3`
BLUE=`tput bold && tput setaf 4`
NC=`tput sgr0`

function RED(){
	echo -e "\n${RED}${1}${NC}"
}
function GREEN(){
	echo -e "\n${GREEN}${1}${NC}"
}
function GREEN2(){
	echo -ne "\n${GREEN}${1}${NC}"
}
function YELLOW(){
	echo -e "\n${YELLOW}${1}${NC}"
}
function BLUE(){
	echo -e "\n${BLUE}${1}${NC}"
}

# Testing if root...
if [ $UID -ne 0 ]
then
	RED "[X] You must run this script as root!" && echo
	exit
fi

GREEN2 "__       _            _               _         _ _   __"
GREEN2 "| _|   __| | ___ _ __ | | ___  _   _  | | ____ _| (_) |_ |"
GREEN2 "| |   / _\` |/ _ \ '_ \| |/ _ \| | | | | |/ / _\` | | |  | |"
GREEN2 "| |  | (_| |  __/ |_) | | (_) | |_| | |   < (_| | | |  | |"
GREEN2 "| |   \__,_|\___| .__/|_|\___/ \__, | |_|\_\__,_|_|_|  | |"
GREEN2 "|__|            |_|            |___/                  |__|"

BLUE "Updating Kali Repositories"
sudo apt update

BLUE "[+] Making Temp Directory for Installation"
mkdir /tmp/deploy_kali
cd /tmp/deploy_kali

BLUE "[+] Installing pip2"
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
sudo python2 get-pip.py
sudo pip2 install --upgrade setuptools

BLUE "[+] Installing ghidra"
wget "https://ghidra-sre.org/ghidra_9.2.3_PUBLIC_20210325.zip" 
sudo unzip ghidra* -d /opt/ghidra
sudo ln -s /opt/ghidra/ghidraRun /usr/bin/ghidra

BLUE "[+] Installing stegsolve"
wget "http://www.caesum.com/handbook/Stegsolve.jar" -O "stegsolve.jar"
chmod +x "stegsolve.jar"
sudo mv stegsolve.jar /usr/bin/stegsolve

BLUE "[+] Installing steghide"
sudo apt install -y steghide

BLUE "[+] Installing stegseek"
wget "https://github.com/RickdeJager/stegseek/releases/download/v0.6/stegseek_0.6-1.deb"
sudo dpkg -i stegseek*

BLUE "[+] Installing GIMP"
sudo apt install -y gimp

BLUE "[+] Installing sshpass"
sudo apt install -y sshpass

BLUE "[+] Installing seclists"
sudo apt install -y seclists

BLUE "[+] Installing pwntools"
sudo pip3 install pwntools

BLUE "[+] Installing RsaCtfTool"
git clone "https://github.com/Ganapati/RsaCtfTool"
sudo mv RsaCtfTool /opt/RsaCtfTool
sudo ln -s /opt/RsaCtfTool/RsaCtfTool.py /usr/bin/RsaCtfTool

BLUE "[+] Installing golang"
sudo apt install -y golang-go

BLUE "[+] Installing rust"
sudo apt install -y rustc

BLUE "[+] Installing rustscan"
wget "https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb"
sudo dpkg -i rustscan*

BLUE "[+] Installing qbittorrent"
sudo apt install -y qbittorrent

BLUE "[+] Installing pavucontrol"
sudo apt install -y pavucontrol

BLUE "[+] Installing virtualbox"
sudo apt install -y virtualbox-qt

BLUE "[+] Installing docker"
sudo apt install -y docker.io
sudo groupadd docker
sudo usermod -aG docker `logname`

BLUE "[+] Installing PEASS"
git clone "https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite"
sudo mv privilege-escalation-awesome-scripts-suite /opt/

BLUE "[+] Installing nishang"
git clone "https://github.com/samratashok/nishang"
sudo mv nishang /opt/

BLUE "[+] Installing discord"
wget "http://ftp.br.debian.org/debian/pool/main/liba/libappindicator/libappindicator1_0.4.92-7_amd64.deb"
wget "http://ftp.br.debian.org/debian/pool/main/libi/libindicator/libindicator7_0.5.0-4_amd64.deb"
wget "https://dl.discordapp.net/apps/linux/0.0.14/discord-0.0.14.deb"
sudo dpkg -i libindicator7* && sudo apt-get install -f && sudo dpkg -i libappindicator* && sudo apt-get install -f && sudo dpkg -i discord* && sudo apt-get install -f

BLUE "[+] Installing betterdiscord and updating theme"
curl -O https://raw.githubusercontent.com/bb010g/betterdiscordctl/master/betterdiscordctl
chmod +x betterdiscordctl
sudo mv betterdiscordctl /usr/local/bin
/usr/local/bin/betterdiscordctl install
wget "https://raw.githubusercontent.com/p1xxxel/solarized-terminal-discord/main/Solarized-Dark-Terminal.theme.css" -P /home/`logname`/.config/BetterDiscord/themes/

BLUE "[+] Installing brave"
sudo apt install apt-transport-https curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser

BLUE "[+] Installing dwm"
git clone "https://github.com/p1xxxel/dwm.git"
sudo mv dwm /opt/dwm
cd /opt/dwm && sudo make clean install && cd /tmp/deploy_kali

BLUE "[+] Installing dmenu"
git clone "https://github.com/p1xxxel/dmenu.git"
sudo apt install libyajl-dev
sudo mv dmenu /opt/dmenu
cd /opt/dmenu && sudo make clean install && cd /tmp/deploy_kali

BLUE "[+] Installing Ubuntu Mono font"
wget "https://fonts.google.com/download?family=Ubuntu%20Mono"
unzip Ubuntu_Mono*
mv *ttf /usr/share/fonts
fc-cache

BLUE "[+] Installing Alacritty"
wget "https://github.com/alacritty/alacritty/releases/download/v0.4.2/Alacritty-v0.4.2-ubuntu_18_04_amd64.deb"
sudo dpkg -i Alacritty*
mkdir /home/`logname`/.config/alacritty

BLUE "[+] Installing dotfiles"
git clone "https://github.com/p1xxxel/dotfiles.git"
cp -r dotfiles/. /home/`logname`/
mv /home/`logname`/alacritty.yml /home/`logname`/.config/alacritty/
sudo mv /home/`logname`/profile /etc/profile

BLUE "[+] Installing picom"
mv /home/`logname`/picom /usr/bin/
mv /home/`logname`/picom.conf /home/`logname`/.config/

BLUE "[+] Installing polybar"
sudo apt install jsoncpp
mv /home/`logname`/polybar/polybar /usr/bin/
mv /home/`logname`/polybar /home/`logname`/.config/

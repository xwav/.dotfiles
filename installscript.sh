#!/bin/bash

#install software and packages

sudo apt update && \
sudo apt install \

libxft-dev \
libxinerama-dev \
libx11-dev \
xorg \
xserver-xorg \
git \
curl \
wget \
build-essential \
feh \
conky \
lm-sensors \
cmus \
newsboat \
xcompmgr \
alsa-utils \
acpi \
sxiv \
scrot \
zsh \
zsh-autosuggestions \
zsh-syntax-highlighting \
tmux \
most \
rlwrap \
keepassxc \
zathura \
pmount

#create directories 
mkdir ~/.config 

#download and build suckless tools
cd ~/.config
git clone https://github.com/xwav/suckless && \
cd ~/.config/suckless/dwm && make && make clean install 
cd ~/.config/suckless/dmenu && make && make clean install
cd ~/.config/suckless/st && make && make clean install

#download and build nvim
cd ~/.config
git clone https://github.com/neovim/neovim
cd ~/.config/neovim && git checkout stable 
make && make install
cd ~/.config && rm -r neovim

cd ~/.config/
git clone https://github.com/xwav/nvim.git

#download and install cht.sh
curl https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh
chmod +x /usr/local/bin/cht.sh

#pull bare dotfile repo
cd ~
git clone --bare https://github.com/xwav/.dotfiles.git ~/.dotfiles 

function config {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}
mkdir -p ~/.dotfiles-backup && \
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no


# download script for running bashmount
# cd /usr/local/bin
# git clone https://raw.githubusercontent.com/jamielinux/bashmount/master/bashmount

#install GoogleDrive ocamlfuse
apt install \
software-properties-common \
dirmngr \
gnupg-agent

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys AD5F235DF639B041
echo 'deb http://ppa.launchpad.net/alessandro-strada/ppa/ubuntu xenial main' | sudo tee /etc/apt/sources.list.d/alessandro-strada-ubuntu-ppa.list >/dev/null

apt update
apt install \
google-drive-ocamlfuse

#make zsh a default shell
chsh -s $(which zsh) $USER







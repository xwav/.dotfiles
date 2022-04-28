
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
pmount \
jmtpfs \
calcurse


#download and build suckless tools

git clone https://github.com/xwav/suckless $HOME/.config/suckless && \
cd $HOME/.config/suckless/dwm && make && make clean install 
cd $HOME/.config/suckless/dmenu && make && make clean install
cd $HOME/.config/suckless/st && make && make clean install

#download and build nvim

git clone https://github.com/neovim/neovim $HOME/.config/neovim
cd $HOME/.config/neovim && git checkout stable && make && make install
#cd ~/.config && rm -r neovim

#get my bester nvim config :)
git clone https://github.com/xwav/nvim.git $HOME/.config/nvim

#download and install cht.sh
curl https://cht.sh/:cht.sh | tee /usr/local/bin/cht.sh
chmod +x /usr/local/bin/cht.sh


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

#make zsh a default shelll
chsh -s $(which zsh) $USER

# Installing dotfiles 
echo 'alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"' >> $HOME/.zshrc
source ~/.zshrc
echo ".dotfiles" >> .gitignore

git clone --bare https://www.github.com/xwav/.dotfiles.git $HOME/.dotfiles

function dotfiles {
    /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
 }
mkdir -p ~/.dotfiles-backup && \

dotfiles checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
 else
  echo "Backing up pre-existing dot files.";
dotfiles checkout 2>&1 | egrep "\s+\."  | awk {'print $1'} | rev | cut -d/ -f2- | rev | xargs -I{} mkdir -p .dotfiles-backup/{}
dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi;
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no

#to init bare repo on your machine see below

# git init --bare $HOME/.dotfiles.git
# echo 'alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"' >> $HOME/.zshrc
# source ~/.zshrc
# dotfiles config --local status.showUntrackedFiles no
#
# #with 'dotfiles' command execute same commands as with git
# dotfiles status
# dotfiles add .vimrc
# dotfiles commit -m "Add vimrc"
# dotfiles remote add origin https://www.github.com/username/repo.git
# dotfiles push origin master


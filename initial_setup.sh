#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

Log() {
	echo -e "\n${RED}$1${NC}\n"
}

Install() {
	Log "Installing $1"
	sudo apt -y install $1 
}

Clone() {
	cd $2
	Log "Cloning $1 into $2"
	git clone $1
	cd
}
Copy() {
	Log "Coping $1 in $2"
	cp $1 $2
}

Pip() {
	Log "Pip: installing $1"
	pip install $1 
}

Log "Updating" 
sudo apt -y update

Log "Upgrading"
sudo apt -y upgrade

####################
Log "rcfiles setup"
####################
Clone "https://github.com/gamberoillecito/rcfiles.git" .

# neovim
mkdir ./.config/nvim/
Copy "rcfiles/init.vim" ".config/nvim/"

# tmux
Log "Copying tmux rc file"
Copy ~/rcfiles/tmux.conf ~/.tmux.conf

Log "Setting zsh as the default shell"
chsh -s $(which zsh)


Install neovim

Install git

Install tmux

Install curl

Log "Git setup"
git config --global user.name ""
git config --global user.email ""
git config --global credential.helper store
git config --global init.defaultBranch main

###############
#### ZSH ######
###############

Log "type 'exit' after zsh has installed to continue the installation"
Install zsh


Log "Installing OhMyZsh (https://ohmyz.sh/#install)"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

Log "Installing fonts"
mkdir ~/.local/share/fonts
cd ~/.local/share/fonts
curl -L -O "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
curl -L -O "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
curl -L -O "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
curl -L -O "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
cd
fc-cache -f -v
touch ~/.Xresources
echo "xterm*faceName: MesloLGS NF" >> ~/.Xresources

Log "Installing Powerlevel10k (https://github.com/romkatv/powerlevel10k#oh-my-zsh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' .zshrc
Copy ~/rcfiles/p10k.zsh ~/.p10k.zsh


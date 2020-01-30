#!/bin/bash

sudo -v

$(pwd)/macOS/defaults.sh
cp $(pwd)/fonts/* /Library/Fonts/

sudo softwareupdate -ia --verbose
xcode-select --install

if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew upgrade --all
brew bundle

curl https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts | sudo tee -a /etc/hosts
egrep -ve "^#|^255.255.255|^0.0.0.0|^127.0.0.1|^0 " /etc/hosts | sort | uniq | sort

clear

ln -sv ~/.dotfiles/.vscode-insiders ~
ln -sv ~/.dotfiles/.config/neofetch/config.conf ~/.config/neofetch/
ln -sv ~/.dotfiles/.vscode ~
ln -sv ~/.dotfiles/.fzf.zsh ~
ln -sv ~/.dotfiles/git/.gitignore_global ~
ln -sv ~/.dotfiles/git/.gitconfig ~
ln -sv ~/.dotfiles/.yabairc ~
ln -sv ~/.dotfiles/.vimrc ~
ln -sv ~/.dotfiles/.vim ~
ln -sv ~/.dotfiles/.skhdrc ~
ln -sv ~/.dotfiles/.zshrc ~
ln -sv ~/.dotfiles/.oh-my-zsh ~

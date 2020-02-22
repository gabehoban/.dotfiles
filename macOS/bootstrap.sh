#!/bin/bash
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# -----------------------------------------------------------------------------
# Preparation: Install Xcode command line tools
# -----------------------------------------------------------------------------
function xcodeCli {
  echo "Installing command line developer tools ..."
  xcode-select --install
}

# -----------------------------------------------------------------------------
# Install package managers
# -----------------------------------------------------------------------------
function packageManagers {
  sudo mkdir /usr/local/temp
  sudo chown -R "$USER":admin /usr/local
  echo "Installing homebrew ..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  echo "Installing cask ..."
  brew tap "homebrew/cask"

  echo "Installing homebrew bundle"
  brew tap "homebrew/bundle"
}

# -----------------------------------------------------------------------------
# Install software
# -----------------------------------------------------------------------------

function software {
  echo "Installing software ..."
  cd ~ && git clone https://github.com/gabehoban/.dotfiles
  brew bundle --file="~/.dotfiles/macOS/Brewfile"
  brew services start koekeishiya/formulae/skhd
  brew services start koekeishiya/formulae/yabai
  npm install -g spaceship-prompt
}

# -----------------------------------------------------------------------------
# Install Code extensions
# -----------------------------------------------------------------------------

function codeExtensions {
  echo "Installing Code extensions ..."
  while read -r extension
  do
    if [[ "$extension" =~ \#.+ ]]
    then
      echo "Skipping ${extension}"
    else
      code-insiders --install-extension "$extension"
    fi
  done < "~/.dotfiles/code/Codefile"
}

# -----------------------------------------------------------------------------
# Setup Mac Defaults
# -----------------------------------------------------------------------------

function defaults {
  sudo $(pwd)/setup/defaults.sh
  cp -vf $(pwd)/fonts/*.ttf ~/Library/Fonts
  chsh -s $(which zsh)
}

# -----------------------------------------------------------------------------
# Setup GPG
# -----------------------------------------------------------------------------
function gpg {
  gpg --recv 0x643624EC29CEA355
}

# -----------------------------------------------------------------------------
# Link Files
# -----------------------------------------------------------------------------
function link {
  $(pwd)/setup/links.sh
}

# -----------------------------------------------------------------------------
# Setup SSH
# -----------------------------------------------------------------------------
function ssh {
  gpg -d -o ~/ssh.tar.gz ~/.dotfiles/gnupg/crypt/ssh.tar.gz.gpg
  tar -xzf /Users/gabehoban/ssh.tar.gz
  mv ~/Users/gabehoban/.ssh ~/.ssh
  rm -rdf ~/Users && rm -f ~/.ssh.tar.gz
}

# -----------------------------------------------------------------------------
# Open apps to setup dock / licenseKeys
# -----------------------------------------------------------------------------
function open {
  open -a Paste
  open -a Brave\ Browser\ Nightly
  open -a The\ Unarchiver
  open -a Dropbox
  open -a Dozer
  open -a iTerm
}

# -----------------------------------------------------------------------------
# RUN
# -----------------------------------------------------------------------------
xcodeCli
packageManagers
software
link
codeExtensions
defaults
gpg
ssh
open
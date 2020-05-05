#!/bin/bash
sudo -v

while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# -----------------------------------------------------------------------------
# Preparation: Install Xcode command line tools
# -----------------------------------------------------------------------------
function xcodeCli {
    echo "Installing command line developer tools..."
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
    
    echo "Installing cask..."
    brew tap "homebrew/cask"
    
    echo "Installing homebrew bundle..."
    brew tap "homebrew/bundle"
}

# -----------------------------------------------------------------------------
# Install npm packages
# -----------------------------------------------------------------------------
function node {
    echo "Installing Node Packages"
    mkdir -p ~/.npm-global
    npm install -g n
    n latest
    
    apps=$(cat "/Users/gabehoban/.dotfiles/packages/node/npm.txt")
    for app in $apps; do
        command -v "$app" > /dev/null
        if [ $? == 1 ]; then
            echo "Installing ${app}"
            npm install -g "$app"
        fi
    done
}

# -----------------------------------------------------------------------------
# Install software
# -----------------------------------------------------------------------------

function software {
    echo "Installing software ..."
    cd ~ && git clone https://github.com/gabehoban/.dotfiles
    brew bundle --file="~/.dotfiles/packages/brew/Tapfile"
    brew bundle --file="~/.dotfiles/packages/brew/Brewfile"
    brew bundle --file="~/.dotfiles/packages/brew/Caskfile"
    brew bundle —-file="~/.dotfiles/packages/brew/Masfile"
    brew cleanup
    brew style
    
    rm -f ~/Library/Preferences/com.apple.dock.plist
    ln -sv ~/.dotfiles/macOS/dock ~/Library/Preferences/com.apple.dock.plist
    
    killall Dock
}

# -----------------------------------------------------------------------------
# Install Code extensions
# -----------------------------------------------------------------------------

function codeExtensions {
    echo "Installing Code extensions ..."
    bash ../code/Codefile
}

# -----------------------------------------------------------------------------
# Setup Mac Defaults
# -----------------------------------------------------------------------------

function defaults {
    cd ~
    sudo ./.dotfiles/macOS/Defaults/defaults.sh
    cp -vf "$(pwd)"/fonts/*.ttf ~/Library/Fonts
    chsh -s "$(command -v zsh)"
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
    cd ~
    ./.dotfiles/macOS/setup/links.sh
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
function runAll(){
    xcodeCli
    packageManagers
    software
    node
    link
    codeExtensions
    defaults
    gpg
    ssh
}

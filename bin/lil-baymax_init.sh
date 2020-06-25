#!/bin/sh

echo "---------------------------------------------------------"
echo "$(tput setaf 2)LIL-BAYMAX: Preparing to power up and begin diagnostics.$(tput sgr 0)"
echo "---------------------------------------------------------"

sudo echo -n
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# We need xcode command tools on Mac
if [[  "$OSTYPE" == 'darwin'* ]]; then
    if ! xcode-select --print-path > /dev/null 2>&1; then
        echo -e "\\033[1;34m-> Installing Xcode Command Line Tools...\\033[0m"
        xcode-select --install &> /dev/null
        # Wait until XCode command tools are installed
        until xcode-select --print-path > /dev/null 2>&1; do
            sleep 5
        done
    fi
fi

echo "---------------------------------------------------------"
echo "$(tput setaf 2)LIL-BAYMAX: Beginning Setup...            "
echo "---------------------------------------------------------"

if [ -d "$HOME/.dotfiles" ]; then
    cd "$HOME"/.dotfiles && git pull
else
    git clone https://github.com/gabehoban/.dotfiles.git "$HOME"/.dotfiles
    cd "$HOME"/.dotfiles || exit
    echo -e "\\033[1;34m-> Done...\\033[0m"
fi

echo "---------------------------------------------------------"
echo "$(tput setaf 2)LIL-BAYMAX: Configuring macOS system.$(tput sgr 0)"
echo "---------------------------------------------------------"

sudo bash .osx

brew="/usr/local/bin/brew"
if [ -f "$brew" ]
then
    echo "---------------------------------------------------------"
    echo "$(tput setaf 2)LIL-BAYMAX: Homebrew is installed.$(tput sgr 0)"
    echo "---------------------------------------------------------"
else
    echo "---------------------------------------------------------"
    echo "$(tput setaf 3)LIL-BAYMAX: Installing Homebrew.$(tput sgr 0)"
    echo "---------------------------------------------------------"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo -e "\\033[1;34m-> Done...\\033[0m"
fi

echo "---------------------------------------------------------"
echo "$(tput setaf 2)LIL-BAYMAX: Installing Homebrew packages.$(tput sgr 0)"
echo "---------------------------------------------------------"
brew bundle --file="$HOME/.dotfiles/brewfile"
echo -e "\\033[1;34m-> Done...\\033[0m"

echo "---------------------------------------------------------"
echo "$(tput setaf 2)LIL-BAYMAX: Symlink files to /Users/gabehoban.$(tput sgr 0)"
echo "---------------------------------------------------------"

link() {
    from="$1"
    to="$2"
    echo -e "\\033[1;34m-> Linking '$from' to '$to'\\033[0m"
    rm -rdf "$to"
    ln -s "$from" "$to"
}

link "$(pwd)"/bin ~/bin
link "$(pwd)"/.config ~/.config

link "$(pwd)"/.zsh ~/.zsh
link "$(pwd)"/.zsh/.zshrc ~/.zshrc
link "$(pwd)"/git/.gitconfig ~/.gitconfig

[ -d ~/.gnupg ] || mkdir -p ~/.gnupg
link "$(pwd)"/.gnupg/gpg.conf ~/.gnupg/gpg.conf
link "$(pwd)"/.gnupg/gpg-agent.conf ~/.gnupg/gpg-agent.conf
link "$(pwd)"/.gnupg/trustdb.gpg ~/.gnupg/trustdb.gpg

link "$(pwd)"/MTMR/items.json ~/Library/Application\ Support/MTMR/items.json
link "$(pwd)"/iTerm2/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
link "$(pwd)"/tmux/.tmux.conf ~/.tmux.conf


echo "---------------------------------------------------------"
echo "$(tput setaf 2)LIL-BAYMAX: Switching shell to zsh. You may need to logout.$(tput sgr 0)"
echo "---------------------------------------------------------"

sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)

echo "---------------------------------------------------------"
echo "$(tput setaf 2)LIL-BAYMAX: Recieving GPG Key.$(tput sgr 0)"
echo "---------------------------------------------------------"
gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv 0x643624EC29CEA355

echo "---------------------------------------------------------"
echo "$(tput setaf 2)LIL-BAYMAX: Decrypting SSH Files.$(tput sgr 0)"
echo "---------------------------------------------------------"
rm -rdf "$HOME"/.ssh
gpg -d -o ssh.tar.gz ~/.dotfiles/gnupg/crypt/ssh.tar.gz.asc
tar -xzf "$(pwd)"/ssh.tar.gz
mv "$(pwd)"/Users/gabehoban/.ssh "$HOME"/.ssh
rm -rdf "$HOME"/.dotfiles/Users && rm -rdf ssh.tar.gz
echo -e "\\033[1;34m-> Done...\\033[0m"

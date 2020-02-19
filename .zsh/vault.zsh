#!/bin/bash
## For GPG encrypting sensitive dotfiles

## Encrypt Vault File with GNUPG
endot() {
    cd ~/.dotfiles/vault
    cp -r "$HOME"/vault "$HOME"/.dotfiles/vault
    tar czf encrypted.tar.gz vault
    gpg -er hobang1@udayton.edu encrypted.tar.gz
    rm encrypted.tar.gz
    rm -rdf vault
}

## Unencrypt Vault File with GNUPG
dedot() {
    cd ~/.dotfiles/vault
    gpg -do encrypted.tar.gz encrypted.tar.gz.gpg
    tar xvf encrypted.tar.gz
    rm encrypted.tar.gz
    mv -r vault ~/vault
}

#!/bin/bash

dbrew() {
    if [[ $@ = *"cask"* ]]; then
        prefix="cask "
        prefix2="install "
        if [[ $(echo "$@" | sed -e "s/^$prefix//") = *" "* ]]; then
            for program in $(echo "$@" | sed -e "s/^$prefix//" | sed -e "s/^$prefix2//")
            do
                echo "cask '$program'" >> ~/.dotfiles/macOS/Brew/Caskfile
                echo "$program added to Caskfile"
            done
        else
            echo "cask '$string'" >> ~/.dotfiles/macOS/Brew/Caskfile
            echo "$string added to Caskfile"
        fi
        brew $@
    else
        prefix="install "
        if [[ $(echo "$@" | sed -e "s/^$prefix//") = *" "* ]]; then
            for program in $(echo "$@" | sed -e "s/^$prefix//")
            do
                echo "brew '$program'" >> ~/.dotfiles/macOS/Brew/Brewfile
                echo "$program added to Brewfile"
            done
        else
            echo "brew '$string'" >> ~/.dotfiles/macOS/Brew/Brewfile
            echo "$string added to Brewfile"
        fi
        brew $@
    fi
}
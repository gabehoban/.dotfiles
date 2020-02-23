#!/bin/bash

. ~/.dotfiles/macOS/Defaults/utils.sh

print_in_purple "\n • Trackpad & Keyboard\n\n"

execute "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true && \
        defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 && \
        defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1" \
    "Trackpad: enable tap to click for this user and for the login screen"

execute "defaults write com.apple.BluetoothAudioAgent 'Apple Bitpool Min (editable)' -int 40" \
    "Increase sound quality for Bluetooth headphones/headsets"

execute "defaults write -g AppleKeyboardUIMode -int 3" \
    "Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)"

execute "defaults write -g ApplePressAndHoldEnabled -bool false" \
    "Disable press-and-hold in favor of key repeat"

execute "defaults write -g 'InitialKeyRepeat_Level_Saved' -int 10" \
    "Set delay until repeat"

execute "defaults write -g KeyRepeat -int 1" \
    "Set the key repeat rate to fast"

execute "defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false" \
    "Disable automatic capitalization"

execute "defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false" \
    "Disable automatic correction"

execute "defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false" \
    "Disable automatic period substitution"

execute "defaults write -g NSAutomaticDashSubstitutionEnabled -bool false" \
    "Disable smart dashes"

execute "defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false" \
    "Disable smart quotes"

execute "defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true" \
    "Follow the keyboard focus while zoomed in"

execute "sudo systemsetup -settimezone 'America/Detroit' > /dev/null"
    "Set the timezone; see 'sudo systemsetup -listtimezones' for other values"

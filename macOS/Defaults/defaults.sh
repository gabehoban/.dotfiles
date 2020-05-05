#!/bin/bash
. ~/.dotfiles/macOS/Defaults/utils.sh
echo `sysctl -n hw.model` `sysctl -n machdep.cpu.brand_string`

print_in_purple "\n • Preferences\n"

./.dotfiles/macOS/Defaults/dock.sh
./.dotfiles/macOS/Defaults/time_machine.sh
./.dotfiles/macOS/Defaults/transmission.sh
./.dotfiles/macOS/Defaults/trackpad.sh
./.dotfiles/macOS/Defaults/ui_and_ux.sh

#!/usr/bin/env bash

# Description: Arch linux check for updates script.
# Dependencies: dmenu, dunst, pacman-contrib, <terminal>
# Use: Run this script on startup with specify terminal to check for update.

# Check internet
ping -c 1 archlinux.org
if [[ "$?" != "0" ]]; then
    echo "No internet to check for updates."
    notify-send "Check for updates script" "No internet to check for updates."
    exit 1
fi

# Check specify terminal
if [[ "$1" = "" ]]; then
    echo -e "ERROR: You need to specify terminal (with run command option) to run this script!\nExample:
    ./d_Arch_update.sh \"alacritty -e\"
    ./d_Arch_update.sh \"st\"
    ./d_Arch_update.sh \"kitty\""
    notify-send "Check for updates script" "Error:\nYou need to specify terminal to run this script!\nUse '-h' option to view example."
    exit 1
# Help
elif [[ "$1" = "-h" ]]; then
    echo -e "You need to specify terminal (with run command option) to run this script!\nExample:
    ./d_Arch_update.sh \"alacritty -e\"
    ./d_Arch_update.sh \"st\"
    ./d_Arch_update.sh \"kitty\""
# Run
elif hash $(echo "$1" | awk '{print $1}') 2>/dev/null; then
    update="$(checkupdates | wc -l)"
    if [[ $update != 0 ]] && [[ $(echo -e "Yes\nNo" | dmenu -i -p "$update packages can be updated! Do you want to update?") = "Yes" ]]; then
        $1 sh -c "echo -e 'Package list:' && checkupdates && sudo pacman -Syu && echo -e '\nSuccessfully!\nPress ENTER to quit.'; read"
        [[ "$?" != "0" ]] && notify-send "Check for updates script" "Command '$1' is not correct to run."
    else
        exit 0
    fi
else
    exit 1
fi

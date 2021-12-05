#!/usr/bin/env bash

# Description: Arch linux check for updates script.
# Dependencies: dmenu, dunst, pacman-contrib, <terminal>
# Use: Run this script on startup with specify terminal to check for update.

check_net() {
# Check internet
    ping -c 1 archlinux.org
    if [[ "$?" != "0" ]]; then
        echo "No internet to check for updates."
        notify-send "Check for updates script" "No internet to check for updates."
        exit 1
    fi
}

no_term() {
# No specify terminal
    echo -e "ERROR: You need to specify terminal (with run command option) to run this script!\nExample:
    ./d_Arch_update.sh \"alacritty -e\"
    ./d_Arch_update.sh \"st\"
    ./d_Arch_update.sh \"kitty\""
    notify-send "Check for updates script" "Error:\nYou need to specify terminal to run this script!\nUse '-h' option to view example."
    exit 1
}

help_h() {
# Help
    echo -e "You need to specify terminal (with run command option) to run this script!\nExample:
    ./d_Arch_update.sh \"alacritty -e\"
    ./d_Arch_update.sh \"st\"
    ./d_Arch_update.sh \"kitty\""
}

run() {
# Run
    update="$(checkupdates | wc -l)"
    if [[ $update != 0 ]] && [[ $(echo -e "Yes\nNo" | dmenu -i -p "$update packages can be updated! Do you want to update?") = "Yes" ]]; then
        $1 sh -c "echo -e 'Package list:' && checkupdates && sudo pacman -Syu && echo -e '\nSuccessfully!\nPress ENTER to quit.'; read"
        [[ "$?" != "0" ]] && notify-send "Check for updates script" "Command '$1' is not correct to run."
    else
        exit 0
    fi
}

main() {
    check_net

    if [[ "$1" = "" ]]; then
        no_term
    elif [[ "$1" = "-h" ]]; then
        help_h
    elif hash $(echo "$1" | awk '{print $1}') 2>/dev/null; then
        run "$1"
    else
        exit 1
    fi
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"

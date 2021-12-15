#!/usr/bin/env bash

# Description: This script help you unmount drives easier!
# Dependencies: dmenu, dunst (or your favorite notification-daemon)
# Tips: you should close all process use mounted folder.
# NOTE: you should edit /etc/sudoers to use 'udisksctl' command without password.
# Otherwise you can't run this script with dmenu.

set -euo pipefail

check_drive() {
    if [[ "$drives" = "" ]]; then
        notify-send "Warning!" "No drive mounted."
        exit 1
    fi
}

unmount() {
    sudo udisksctl unmount -b "$chosen"

    # Success or failure message
    if [[ "$(lsblk -lp | grep "$chosen" | awk '{print $7}')" = "" ]]; then
        pgrep -x dunst && notify-send "Unmount Drive" "$chosen_col $unmounted_col"
    else
        pgrep -x dunst && notify-send --urgency=critical "Unmount Drive" "$chosen\nunmount failed!"
        exit 1
    fi
}

power_off() {
    if [[ "$(echo -e "Yes\nNo" | dmenu -p "Power off a device?")" = "Yes" ]]; then
        sudo udisksctl power-off -b "$chosen"
        pgrep -x dunst && notify-send "Unmount Drive" "$chosen_col\n$safelytoremove_col"
    fi
}

main() {
# Drives mounted at /, /boot, /home will not be options to unmount
# This can be change by modifying $exclusionregex
    exclusionregex="\(/boot/efi\|/home\|/\)$"

    drives="$(lsblk -lp | grep "t /\|k /" | grep -v "$exclusionregex" | awk '{print $1, "(" $4 ")", "on", $7}' || printf "")"
    # TODO: Add `printf ""` because the grep command returns error if nothing is found.

    check_drive

    chosen="$(echo "$drives" | dmenu -i -p "Unmount which drive?" | awk '{print $1}')"
    [[ "$chosen" = "" ]] && exit 1
    
    # Format color display with dunst
    chosen_col="<span foreground='#660000'>$chosen</span>"
    unmounted_col="<span foreground='#00b55b'>unmounted</span>."
    safelytoremove_col="<span foreground='#00b55b'>safely to remove!</span>"

    unmount
    power_off
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"

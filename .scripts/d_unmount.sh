#!/usr/bin/env bash

# Description: This script help you unmount drives easier!
# Dependencies: dmenu, dunst (or your favorite notification-daemon)
# Tips: you should close all process use mounted folder.
# NOTE: you should edit /etc/sudoers to use 'udisksctl' command without password.
# Otherwise you can't run this script with dmenu.
# (see 'Tips and Tricks' in Arch_installation file).

set -euo pipefail

#Drives mounted at /, /boot, /home will not be options to unmount
#This can be change by modifying $exclusionregex

exclusionregex="\(/boot/efi\|/home\|/\)$"
drives="$(lsblk -lp | grep "t /\|k /" | grep -v "$exclusionregex" | awk '{print $1, "(" $4 ")", "on", $7}' || echo "")"
if [[ "$drives" = "" ]]; then
    echo "Cancel" | dmenu -p "WARNING: No drive mounted!"
    exit 1
fi

chosen="$(echo "$drives" | dmenu -i -p "Unmount which drive?" | awk '{print $1}')"
[[ "$chosen" = "" ]] && exit 1
# Format color display with dunst
chosencol="<span foreground='#660000'>$chosen</span>"

sudo udisksctl unmount -b "$chosen"
if [[ "$(lsblk -lp | grep "$chosen" | awk '{print $7}')" = "" ]]; then
    pgrep -x dunst && notify-send "Unmount Drive" "$chosencol <span foreground='#00b55b'>unmounted</span>."
else
    pgrep -x dunst && notify-send --urgency=critical "Unmount Drive" "$chosen\nunmount failed!"
    exit 1
fi

if [[ "$(echo -e "Yes\nNo" | dmenu -p "Power off a device?")" = "Yes" ]]; then
    sudo udisksctl power-off -b "$chosen"
    pgrep -x dunst && notify-send "Unmount Drive" "$chosencol\n<span foreground='#00b55b'>safely to remove!</span>"
fi

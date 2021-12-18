#!/usr/bin/env bash

# Description: This script use to change background with feh.
# Dependencies: dmenu, feh, dunst
# Note: You need specify locate of folder contain wallpapers.
# Ex:
#   ./dmsetbg.sh ~/Wallpapers

set -euo pipefail

main() {
    if [[ "$1" = "" ]] || [[ ! -d "$1" ]]; then
        echo -e "You need specify locate of folder contain wallpapers!
        Ex: ./dmsetbg.sh ~/Wallpapers"
        notify-send "Set background" "Error:\nYou need specify locate of folder contain wallpapers!\nEx: <span foreground='#00b55b'>./dmsetbg.sh ~/Wallpapers</span>"
        exit 1
    fi
    chosen="$1/$(find ~/Wallpapers -type f -printf '%f\n' | sort | dmenu -l 20 -i -p "Choose wallpaper:")"
    if [[ ! -f "$chosen" ]]; then
        exit 1
    else
        feh --bg-scale "$chosen"
        notify-send "Set background" "Wallpaper change successfully!"
    fi
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"

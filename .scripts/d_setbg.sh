#!/usr/bin/env bash

# Description: This script use to change background with feh.
# Dependencies: dmenu, feh, dunst
# Note: You need specify locate of folder contain wallpapers.
# Ex:
#   ./d_setbg.sh ~/Wallpapers

set -euo pipefail

main() {
    if [[ "$1" = "" ]] || [[ ! -d "$1" ]]; then
        echo -e "You need specify locate of folder contain wallpapers!
        Ex: ./d_setbg.sh ~/Wallpapers"
        notify-send "Set background" "Error:\nYou need specify locate of folder contain wallpapers!\nEx: <span foreground='#00b55b'>./d_setbg.sh ~/Wallpapers</span>"
        exit 1
    fi
    chosen="$(ls $1 | dmenu -l 20 -i -p "Choose wallpaper:")"
    if [[ "$chosen" = "" ]] || [[ ! -f "$1/$chosen" ]]; then
        exit 1
    else
        feh --bg-scale "$1/$chosen"
        notify-send "Set background" "Wallpaper change successfully!"
    fi
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"

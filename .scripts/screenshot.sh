#!/usr/bin/env bash

# Description: Take screenshot with ffmpeg.
# Dependencies: ffmpeg, slop, xclip, dunst

# Usage:
# `$0`: full screen capture
# `$0 selected`: capture selected area

set -euo pipefail

screenshot_full() {
    ffmpeg -f x11grab -video_size "$(xdpyinfo | awk '/dimensions/{print $2}')" -i "$DISPLAY" -vframes 1 "$locate"
}

screenshot_selected() {
    selected=$(slop -f "%x %y %w %h")
    X=$(echo "$selected" | awk '{print $1}')
    Y=$(echo "$selected" | awk '{print $2}')
    W=$(echo "$selected" | awk '{print $3}')
    H=$(echo "$selected" | awk '{print $4}')
    ffmpeg -f x11grab -video_size "$W"x"$H" -i :0.0+"$X,$Y" -vframes 1 "$locate"
}

main() {
    [[ ! -d "${HOME}/Pictures" ]] && mkdir -p "${HOME}"/Pictures
    locate="${HOME}/Pictures/screenshot-$(date +'%y%m%d-%H%M-%S').png"
    case "$@" in
        selected) screenshot_selected;;
        "") screenshot_full;;
        *) exit 1;;
    esac
    # Copy image to clipboard
    xclip -sel clipboard -t image/png -i "$locate"

    notify-send "Screenshot" "Copied to clipboard!\nSaved to:\n$locate"
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"

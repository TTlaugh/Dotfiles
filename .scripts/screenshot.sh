#!/usr/bin/env bash

# Description: Take screenshot with ffmpeg.
# Dependencies: ffmpeg, slop, dunst

# Usage:
# `$0`: screenshot full screen
# `$0 selected`: screenshot selected region

set -euo pipefail

screenshot_full() {
    ffmpeg -f x11grab -video_size $(xdpyinfo | awk '/dimensions/{print $2}') -i $DISPLAY -vframes 1 "$locate"
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
    locate="${HOME}/Pictures/screenshot--$(date +'%Y-%m-%d--%H-%M-%S').png"

    case "$@" in
        selected) screenshot_selected;;
        "") screenshot_full;;
        *) exit 1;;
    esac

    notify-send "Screenshot" "Saved to $locate"
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"

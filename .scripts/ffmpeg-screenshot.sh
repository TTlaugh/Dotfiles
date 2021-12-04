#!/usr/bin/env bash

# Description: Take screenshot with ffmpeg.
# Dependencies: ffmpeg, dunst

set -euo pipefail

main() {
    locate="${HOME}/Pictures/screenshot--$(date +'%Y-%m-%d--%H-%M-%S').png"
    ffmpeg -f x11grab -video_size $(xdpyinfo | awk '/dimensions/{print $2}') -i $DISPLAY -vframes 1 "$locate"
    notify-send "Screenshot" "Saved to $locate"
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"

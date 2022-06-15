#!/usr/bin/env bash

picom &
nm-applet &
exec "$HOME"/.fehbg &
xset s off && xset -dpms && xset s noblank &

# Run the aems script to send a message asking if the user wants to enable automatic email sync.
setsid -f "$HOME"/.config/qtile/scripts/aems

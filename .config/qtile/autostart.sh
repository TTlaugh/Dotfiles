#!/bin/sh

autostart="nm-applet unclutter" # powersave
for program in $autostart; do
    pidof -s "$program" || "$program" &
done >/dev/null 2>&1

xset s off &
xset -dpms &
xset s noblank &

#exec "$HOME"/.fehbg &
feh --bg-fill ~/.config/qtile/images/qtile_bg.png &

trayer \
   --edge top \
   --align right \
   --widthtype request \
   --padding 5 \
   --margin 10 \
   --distance 2 \
   --SetDockType true \
   --SetPartialStrut false \
   --expand true \
   --monitor 0 \
   --transparent true \
   --alpha 0 \
   --tint 0x414868 \
   --height 23 &

picom --experimental-backends || picom &

# Run the aems script to send a message asking if the user wants to enable automatic email sync. (mutt-wizard)
#setsid -f "$HOME"/.scripts/aems

#!/usr/bin/env bash

# Description: Vifm with dmenu and your terminal.
# Dependencies: vifm, dmenu, dunst, <terminal>
# Note: you need to specify terminal to run script.
# Ex:
#   ./d_vifm.sh "alacritty -e"
#   ./d_vifm.sh "st"

# Check specify terminal
if [[ "$1" = "" ]]; then
    echo -e "ERROR: You need to specify terminal (with run command option) to run this script!\nExample:
    ./d_vifm.sh \"alacritty -e\"
    ./d_vifm.sh \"st\"
    ./d_vifm.sh \"kitty\""
    notify-send "Vifm" "Error:\nYou need to specify terminal to run this script!\nUse '-h' option to view example."
    exit 1
# Help
elif [[ "$1" = "-h" ]]; then
    echo -e "You need to specify terminal (with run command option) to run this script!\nExample:
    ./d_vifm.sh \"alacritty -e\"
    ./d_vifm.sh \"st\"
    ./d_vifm.sh \"kitty\""
# Run
elif hash $(echo "$1" | awk '{print $1}') 2>/dev/null; then
    path="$(find /home/nltt /mnt -maxdepth 1 -type d)\n$(find / -maxdepth 1 -type d)"
    chosen="$(echo -e "$path" | dmenu -i -p "Vifm:")"
    if [[ "$chosen" = "" ]] || [[ ! -d "$chosen" ]]; then
        exit 1
    else
        $1 sh -c "vifm $chosen"
        [[ "$?" != "0" ]] && notify-send "Vifm" "Command '$1' is not correct to run."
    fi
else
    exit 1
fi

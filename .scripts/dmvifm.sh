#!/usr/bin/env bash

# Description: Vifm with dmenu and your terminal.
# Dependencies: vifm, dmenu, dunst, <terminal>
# Note: you need to specify terminal to run script.
# Ex:
#   ./dmvifm.sh "alacritty -e"
#   ./dmvifm.sh "st"

no_term(){
# No specify terminal
    echo -e "ERROR: You need to specify terminal (with run command option) to run this script!\nExample:
    ./dmvifm.sh \"alacritty -e\"
    ./dmvifm.sh \"st\"
    ./dmvifm.sh \"kitty\""
    notify-send "Vifm" "Error:\nYou need to specify terminal to run this script!\nUse '-h' option to view example."
    exit 1
}

help_h() {
# Help
    echo -e "You need to specify terminal (with run command option) to run this script!\nExample:
    ./dmvifm.sh \"alacritty -e\"
    ./dmvifm.sh \"st\"
    ./dmvifm.sh \"kitty\""
}

run() {
# Run
    path="$(find /home/nltt /mnt -maxdepth 1 -type d)\n$(find / -maxdepth 1 -type d)"
    chosen="$(echo -e "$path" | dmenu -i -p "Vifm:")"
    if [[ "$chosen" = "" ]] || [[ ! -d "$chosen" ]]; then
        exit 1
    else
        $1 sh -c "vifm $chosen"
        [[ "$?" != "0" ]] && notify-send "Vifm" "Command '$1' is not correct to run." && exit 1
    fi
}

main() {
    if [[ "$1" = "" ]]; then
        no_term
    elif [[ "$1" = "-h" ]]; then
        help_h
    elif hash $(echo "$1" | awk '{print $1}') 2>/dev/null; then
        run "$1"
    else
        exit 1
    fi
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"

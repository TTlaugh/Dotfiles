#!/usr/bin/env bash

set -euo pipefail

wifi() {
    wifi="$(nmcli -t -f active,ssid dev wifi | grep "yes" | cut -c 5-)"
    [[ -z "$wifi" ]] && wifi="Disconnected"
    echo "$wifi"
}

update() {
    update="$(checkupdates | wc -l)"
    echo "$update packages"
}

cpu() {
    read cpu a b c previdle rest < /proc/stat
    prevtotal=$((a+b+c+previdle))
    sleep 0.5
    read cpu a b c idle rest < /proc/stat
    total=$((a+b+c+idle))
    cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
    echo -e "$cpu%"
}

note() {
    note=$(cat ~/note | grep "(*) Note:")
    [[ -z "$note" ]] && note="No notes"
    echo "$note"
}

main() {
    time=" $(date "+%H:%M:%S")"
    date=" $(date "+%A %d/%m/%Y")"
    wifi=" $(wifi)"
    
    update="$(update)"
    icon1="<span foreground='#0ecc00'> </span>"
    
    cpu=" Cpu: $(cpu)"
    icon2="<span foreground='#007396'>龍 </span>"
    
    mem=" Mem: $(free -h | grep "Mem" | awk '{print $3"B"}')"
    icon3="<span foreground='#ba9500'> </span>"
    
    disk="Disk: $(df -h | grep "/$" | awk '{print $4}')"
    icon4="<span foreground='#660000'> </span>"
    
    volume="  Vol: $(pamixer --get-volume)%"
    
    notify-send "Status" "$time\n$date\n$wifi\n\n$icon1$update\n\n$icon2$cpu\n$icon3$mem\n$icon4$disk\n$volume"

    if [[ -f "$HOME/note" ]]; then
        note="$(note)"
        notify-send "NOTE" "$note"
    else
        notify-send "NOTE" "Note file not found."
    fi
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"

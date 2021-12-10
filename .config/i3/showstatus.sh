#!/usr/bin/env bash

cpu() {
    read cpu a b c previdle rest < /proc/stat
    prevtotal=$((a+b+c+previdle))
    sleep 0.5
    read cpu a b c idle rest < /proc/stat
    total=$((a+b+c+idle))
    cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
    echo -e "$cpu%"
}

time=" $(date "+%H:%M:%S")"
date=" $(date "+%A %d/%m/%Y")"

update="$(checkupdates | wc -l) packages"
icon1="<span foreground='#0ecc00'> </span>"

cpu="Cpu:  $(cpu)"
icon2="<span foreground='#007396'>龍 </span>"

mem="Mem:  $(free -h | grep "Mem" | awk '{print $3"B"}')"
icon3="<span foreground='#ba9500'> </span>"

disk="Disk: $(df -h | grep "/$" | awk '{print $4}')"
icon4="<span foreground='#660000'> </span>"

volume=" $(pamixer --get-volume)%"

notify-send "Status" "$time\n$date\n\n$icon1$update\n\n$icon2$cpu\n$icon3$mem\n$icon4$disk\n$volume"
#notify-send "Status" "$time\n$date\n\n$icon2$cpu\n$icon3$mem\n$icon4$disk\n$volume"

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
date=" $(date "+%A, %d/%m/%y")"
update=" $(checkupdates | wc -l) packages"
cpu="龍 $(cpu)"
mem=" $(free -h | grep "Mem" | awk '{print $3}')"
disk=" $(df -h | grep "/$" | awk '{print $4}')"
volume=" $(pamixer --get-volume)%"

status=$(echo -e "$time\n$date\n$update\n$cpu\n$mem\n$disk\n$volume")
notify-send "Status" "$status"

#!/usr/bin/env bash

common() {
    echo -n "\"border\": \"$1\","
    echo -n "\"separator\":false,"
    echo -n "\"separator_block_width\":10,"
    echo -n "\"border_top\":0,"
    echo -n "\"border_bottom\":2,"
    echo -n "\"border_left\":0,"
    echo -n "\"border_right\":0"
}

myip_local() {
    ip=$(ip route get 1 | sed -n 's/.*src \([0-9.]\+\).*/\1/p')
    echo -n "{"
    echo -n "\"name\":\"ip_local\","
    if [ -n "$ip" ]; then
        echo -n "\"full_text\":\"  $ip \","
        echo -n "\"color\":\"#00ff33\""
    else
        echo -n "\"full_text\":\" Disconnected \","
        echo -n "\"color\":\"#ff0000\""
    fi
    echo -n "},"
}

update=$(checkupdates | wc -l)
systemupdate() {
    if (( $update > 0)); then
        echo -n "{"
        echo -n "\"name\":\"id_systemupdate\","
        echo -n "\"full_text\":\"  ${update}\""
        echo -n "},"
    fi
}

cpu() {
    read -r cpu a b c previdle rest < /proc/stat
    prevtotal=$((a+b+c+previdle))
    sleep 0.5
    read -r cpu a b c idle rest < /proc/stat
    total=$((a+b+c+idle))
    cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
    echo -e "$cpu %"
}
cpu_usage() {
    echo -n "{"
    echo -n "\"name\":\"id_cpu_usage\","
    echo -n "\"full_text\":\"  $(cpu) \","
    common "#ff79c6"
    echo -n "},"
}

memory() {
    echo -n "{"
    echo -n "\"name\":\"id_memory\","
    echo -n "\"full_text\":\"  $(free -h | grep "Mem" | awk '{print $3"B"}')\","
    common "#50fa7b"
    echo -n "},"
}

disk_usage() {
    echo -n "{"
    echo -n "\"name\":\"id_disk_usage\","
    echo -n "\"full_text\":\"  $(df -h | grep -w "/" | awk '{print $4}')\","
    common "#ffb86c"
    echo -n "},"
}

volume() {
    vol=$(pamixer --get-volume)
    mute=$(pamixer --get-mute)
    echo -n "{"
    echo -n "\"name\":\"id_volume\","
    if [ "$mute" = "false" ]; then
        echo -n "\"full_text\":\"  ${vol}% \""
    else
        echo -n "\"full_text\":\"  ${vol}% \""
    fi
    echo -n "},"
}

battery0() {
    if [ -f /sys/class/power_supply/BAT0/uevent ]; then
        prct=$(cat /sys/class/power_supply/BAT0/uevent | grep "POWER_SUPPLY_CAPACITY=" | cut -d'=' -f2)
        charging=$(cat /sys/class/power_supply/BAT0/uevent | grep "POWER_SUPPLY_STATUS" | cut -d'=' -f2)
        icon=""
        if [ "$charging" == "Charging" ]; then
            icon=""
        fi
        echo -n "{"
        echo -n "\"name\":\"battery0\","
        echo -n "\"full_text\":\" ${icon} ${prct}% \""
        echo -n "},"
    fi
}

mydate() {
    echo -n "{"
    echo -n "\"name\":\"id_time\","
    echo -n "\"full_text\":\" $(date "+%A, %b %d  %H:%M") \""
    echo -n "},"
}

logout() {
    echo -n "{"
    echo -n "\"name\":\"id_logout\","
    echo -n "\"full_text\":\"  \""
    echo -n "}"
}

echo '{ "version": 1, "click_events":true }'
echo '['
echo '[]'

(while :;
do
    echo -n ",["
    myip_local
    systemupdate
    cpu_usage
    memory
    disk_usage
    volume
    battery0
    mydate
    logout
    echo "]"
    sleep 1
done) &

# click events
while read line;
do
    # CHECK UPDATES
    if [[ $line == *"name"*"id_systemupdate"* ]]; then
        alacritty -e sudo pacman -Syu &
    
    # CPU
    elif [[ $line == *"name"*"id_cpu_usage"* ]]; then
        alacritty -e htop &
    
    # TIME
    elif [[ $line == *"name"*"id_time"* ]]; then
        notify-send "$(cal)" &
    
    # VOLUME
    elif [[ $line == *"name"*"id_volume"* ]]; then
        alacritty -e alsamixer &
    
    # LOGOUT
    elif [[ $line == *"name"*"id_logout"* ]]; then
        i3-nagbar -m 'Arch Linux' -t warning -B 'Shutdown' 'shutdown now' -B 'Restart' 'reboot' -B 'Suspend' 'systemctl suspend' -B 'Exit i3' 'i3-msg exit' -B 'Keyboard' 'onboard' -B 'Terminal' 'i3-sensible-terminal' > /dev/null &
    fi  
done

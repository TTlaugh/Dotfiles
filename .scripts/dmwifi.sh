#!/usr/bin/env bash

# Description: Connect to wifi using dmenu.
# Dependencies: dmenu, nmcli, Any Nerd Font

set -euo pipefail

main() {
    refresh=$(echo -e "No\nYes" | dmenu -i -p "Refresh?")
    [[ "$refresh" = "Yes" ]] && nmcli radio wifi off && nmcli radio wifi on && sleep 5

    bssid=$(nmcli device wifi list | sed -n '1!p' | cut -b 9- | dmenu -i -l 20 -p "Select Wifi  :" | cut -d' ' -f1)
    pass=$(echo "" | dmenu -i -l 20 -p "Enter Password  :")
    
    [ -n "$pass" ] && nmcli device wifi connect "$bssid" password "$pass" || nmcli device wifi connect "$bssid"
    sleep 10
    if ping -q -c 2 -W 2 archlinux.org >/dev/null; then
      notify-send "Wifi connection" "Your internet is working :)"
    else
      notify-send "Wifi connection" "Your internet is not working :("
    fi
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"

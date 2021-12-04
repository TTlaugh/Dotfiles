#!/usr/bin/env bash

# Description: Search for a process to kill.
# Dependencies: dmenu, dunst

set -euo pipefail

main() {
    selected="$(ps --user "$USER" -F | dmenu -i -l 20 -p "Kill:" | awk '{print $2" ("$11")"}')"
    if [[ -n $selected ]]; then
        answer="$(echo -e "No\nYes" | dmenu -p "Kill: $selected?")"
        if [[ "$answer" = "Yes" ]]; then
            id="$(echo "$selected" | awk '{print $1}')"
            kill -9 "$id"
            echo "Process $selected has been killed."
            pgrep -x dunst && notify-send "Kill process script" "Process '$selected' has been killed."
            exit 0
        else
            echo "Program terminated." && exit 1
        fi
    fi
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"

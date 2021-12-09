#!/usr/bin/env bash

# Description: Use dmenu to run command with [Yes/No] waring.
# Dependencies: dmenu
# Use: Gives a prompt labeled with $1 to perform command $2.
# Ex:
# ./dmpower.sh "Are you sure you want to shutdown?" "shutdown now"

set -euo pipefail

[ $(echo -e "No\nYes" | dmenu -i -p "$1") = "Yes" ] && $2

############ Use commands below to mapping key if you don't want to use script file ###############
#[ $(echo -e "No\nYes" | dmenu -i -p "Are you sure you want to exit i3?") = "Yes" ] && i3-msg exit                      
#[ $(echo -e "No\nYes" | dmenu -i -p "Are you sure you want to suspend?") = "Yes" ] && systemctl suspend                
#[ $(echo -e "No\nYes" | dmenu -i -p "Are you sure you want to reboot?") = "Yes" ] && reboot                            
#[ $(echo -e "No\nYes" | dmenu -i -p "Are you sure you want to shutdown?") = "Yes" ] && shutdown now

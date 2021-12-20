#!/usr/bin/env bash

# Description: simple calculator.
# Dependencies: dmenu, python
# Note: sorry... this script very bad :((, it's slow and just enough for me.

set -euo pipefail

FLAG="0"
while :
do
    if [[ "$FLAG" = "0" ]]; then
        expre="$(echo -e "Enter your expression\nquit" | dmenu -p "Calc:")"
        if [[ "$expre" = "Enter your expression" ]]; then
            continue
        elif [[ "$expre" = "" ]] || [[ "$expre" = "quit" ]]; then
            exit 1
        fi
        res="$(echo "exit()" | python -i -c "$(echo -e "from math import *\nprint($expre)")")"
    else
        ansexpre="$(echo "Example: ans+1" | dmenu -i -p "(Ans= $res)")"
        [[ "$ansexpre" = "Example: ans+1" ]] || [[ "$ansexpre" = "" ]] && exit 1
        res="$(echo "exit()" | python -i -c "$(echo -e "from math import *\nans=$ans\nprint($ansexpre)")")"
    fi
    
    if [[ "$res" = "True" ]] || [[ "$res" = "False" ]]; then
        echo "$res" | dmenu -p "Result:"
        exit 0
    elif [[ "$res" = "" ]]; then
        exit 1
    fi
    
    dres="$(echo -e "= $res (Enter to use 'ans')\nAC\nquit"| dmenu -i -l 3 -p "Result:")"
    if [[ "$dres" = "= $res (Enter to use 'ans')" ]];then
        FLAG="1"
        ans="$res"
    elif [[ "$dres" = "AC" ]]; then
        FLAG="0"
    elif [[ "$dres" = "" ]]; then
        exit 1
    elif [[ "$dres" = "quit" ]]; then
        exit 0
    fi
done

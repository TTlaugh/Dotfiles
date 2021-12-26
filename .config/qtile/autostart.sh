#!/usr/bin/env bash

lxsession &
picom --config ~/.config/picom/picom.conf &
nm-applet &
exec ~/.fehbg &

#!/usr/bin/env bash

lxsession &
picom --config "$HOME"/.config/picom/picom.conf &
nm-applet &
exec "$HOME"/.fehbg &

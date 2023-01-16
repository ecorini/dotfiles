#!/bin/sh

if [[ $(wmctrl -l | grep nmtui) == '' ]]; then
    xfce4-terminal -e nmtui -T nmtui
fi




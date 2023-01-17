#!/usr/bin/env bash

## Shows a drop down menu with power options

## Generic bemenu script. Will be run from other scripts to make sure, bemenu always looks the same

background='#1a1a1a'
background_items='#efefef'
color5='#268bd2'

BEMENU_ARGS=(
  -i
  -p 'Power:'
  --fn 'JetBrainsMono NF 16'
  --tb "$background"
  --tf "$color5"
  --fb "$background"
  --nb "$background"
  --ab "$background"
  --hb "$background_items"
  --hf "$color5"
  --line-height 32
  "$@")

case "$(echo -e "Logout / Exit\nLock\nPower Off\nReboot\nSuspend then hibernate\n" | bemenu "${BEMENU_ARGS[@]}")" in
"Logout / Exit") loginctl terminate-user $USER ;;
"Lock") loginctl lock-session ;;
"Power Off") exec systemctl poweroff -i ;;
"Reboot") exec systemctl reboot ;;
"Suspend then hibernate") exec systemctl suspend-then-hibernate ;;
esac

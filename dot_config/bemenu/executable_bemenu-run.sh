#!/usr/bin/env bash

## Generic bemenu script. Will be run from other scripts to make sure, bemenu always looks the same

if [ -f "$HOME/.cache/wal/colors.sh" ]; then
  source $HOME/.cache/wal/colors.sh
else
  background='#1a1a1a'
  background_items='#efefef'
  color5='#268bd2'
  #color6='#2E3440'
fi

BEMENU_ARGS=(
  -i
  -p 'Run:'
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

bemenu-run "${BEMENU_ARGS[@]}"

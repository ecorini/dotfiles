#!/usr/bin/env bash

filter="blue-light-filter"

if [[ $1 = "toggle" ]]; then
  hyprshade toggle $filter
fi

if [[ $(hyprshade current) == $filter ]]; then
  echo "On"
  echo "Nightlight is on"
else
  echo "Off"
  echo "Nightlight is off"
fi

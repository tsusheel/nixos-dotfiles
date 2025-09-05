#!/usr/bin/env bash

STEP=5   # percent step
MIN=10   # minimum brightness in percent

cur=$(brightnessctl g)
max=$(brightnessctl m)
perc=$((cur * 100 / max))

if   [ "$perc" -eq 10 ];  then
  icon="🌑" # lowest
elif [ "$perc" -le 25 ]; then
  icon="🌒"   # low
elif [ "$perc" -le 50 ]; then
  icon="🌓"   # medium
elif [ "$perc" -le 75 ]; then
  icon="🌔"   # high
else
  icon="🌕"   # max
fi

case "$1" in
  up)
    brightnessctl -q set +${STEP}%
    ;;
  down)
    if [ "$perc" -le "$MIN" ]; then
      brightnessctl -q set ${MIN}%
    else
      brightnessctl -q set ${STEP}%-
    fi
    ;;
  get)
    # print current percentage (for Waybar exec)
    echo "$icon $perc"
    ;;
  *)
    echo "Usage: $0 {up|down|get}"
    exit 1
    ;;
esac

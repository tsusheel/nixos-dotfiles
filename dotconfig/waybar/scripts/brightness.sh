#!/usr/bin/env bash

STATE_FILE="$HOME/.config/waybar/state/gammastep-brightness"
DEFAULT_BRIGHTNESS=0.8

# Initialize state if not present
if [ ! -f "$STATE_FILE" ]; then
    echo "$DEFAULT_BRIGHTNESS" > "$STATE_FILE"
fi

CURRENT=$(cat "$STATE_FILE")
STEP=0.1

case "$1" in
  up)
    NEW=$(awk -v val="$CURRENT" -v step="$STEP" 'BEGIN {n = val + step; if (n > 1) n = 1; print n}')
    ;;
  down)
    NEW=$(awk -v val="$CURRENT" -v step="$STEP" 'BEGIN {n = val - step; if (n < 0.1) n = 0.1; print n}')
    ;;
  set)
    NEW="$2"
    ;;
  *)
    NEW="$CURRENT"
    ;;
esac

# Save new brightness and apply
echo "$NEW" > "$STATE_FILE"
gammastep -l 0:0 -t 6500K:6500K -b $NEW:$NEW

# Output percentage for Waybar
PERCENT=$(awk -v b="$NEW" 'BEGIN { printf("%.0f", b * 100) }')
echo "{\"text\": \"☀ $PERCENT%\", \"tooltip\": \"Brightness: $PERCENT%\"}"


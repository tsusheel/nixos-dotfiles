#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Wallpapers"
SYMLINK="$HOME/.config/hypr/current-wallpaper"
INDEX_FILE="$HOME/.config/hypr/.wallpaper-index"

# Load wallpapers in alphabetical order
mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | sort)

TOTAL=${#WALLPAPERS[@]}
[[ $TOTAL -eq 0 ]] && echo "No wallpapers found." && exit 1

# Read current index or default to 0
if [[ -f "$INDEX_FILE" ]]; then
    INDEX=$(<"$INDEX_FILE")
else
    INDEX=0
fi

# Direction: forward or backward
DIRECTION="$1"

if [[ "$DIRECTION" == "backward" ]]; then
    INDEX=$((INDEX - 1))
    if (( INDEX < 0 )); then
        INDEX=$((TOTAL - 1))
    fi
else
    INDEX=$((INDEX + 1))
    if (( INDEX >= TOTAL )); then
        INDEX=0
    fi
fi

# Save updated index
echo "$INDEX" > "$INDEX_FILE"

# Set wallpaper
WALLPAPER="${WALLPAPERS[$INDEX]}"
rm -f "$SYMLINK"
ln -s "$WALLPAPER" "$SYMLINK"

# Show wallpaper with transition
swww img "$SYMLINK" --transition-type fade --transition-duration 0.1


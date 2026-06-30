#!/bin/bash

# Check if wlogout is already running
if pgrep -x "wlogout" > /dev/null; then
    pkill -x "wlogout"
    exit 0
fi

height=1080
if command -v hyprctl &>/dev/null && command -v jq &>/dev/null; then
    height=$(hyprctl monitors -j | jq -r '.[] | select(.focused==true) | "\(.height) \(.scale)"' | awk '{print int($1/$2)}' 2>/dev/null)
fi
margin=$((height / 3))

wlogout \
    --layout ~/.config/wlogout/layout \
    --css ~/.config/wlogout/style.css \
    --protocol layer-shell \
    --buttons-per-row 5 \
    --margin-top "$margin" \
    --margin-bottom "$margin"

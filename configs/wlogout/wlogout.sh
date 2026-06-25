#!/bin/bash

# Check if wlogout is already running
if pgrep -x "wlogout" > /dev/null; then
    pkill -x "wlogout"
    exit 0
fi

wlogout \
    --layout ~/.config/wlogout/layout \
    --css ~/.config/wlogout/style.css \
    --protocol layer-shell \
    -b 5 \
    -T 380 \
    -B 380

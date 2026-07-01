#!/bin/bash

# Take a full screen screenshot
filename=~/Pictures/screenshots/$(date '+%Y-%m-%d_%H-%M-%S').png
grimblast --freeze copysave screen "$filename"

if [ $? -eq 0 ]; then
    action=$(notify-send "Screenshot" "Saved and copied to clipboard" \
        -i "$filename" \
        -u low \
        --action="default=Open" \
        --wait)

    if [ "$action" = "default" ]; then
        gwenview "$filename"
    fi
fi

#!/bin/bash

# Take the screenshot
filename=~/Pictures/Screenshots/$(date '+%Y-%m-%d_%H-%M-%S').png
grimblast --freeze copysave area "$filename"

if [ $? -eq 0 ]; then
    # Send clickable notification
    action=$(notify-send "Screenshot" "Saved and copied to clipboard" \
        -i "$filename" \
        -u low \
        --action="default=Open" \
        --wait)
    
    # Open image if notification clicked
    if [ "$action" = "default" ]; then
        gwenview "$filename"
    fi
fi

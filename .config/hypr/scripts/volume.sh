#!/bin/bash

# Get current volume (0.0 to 1.0 format)
current=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')
current_percent=$(echo "$current * 100" | bc)

# Adjust based on argument
if [ "$1" = "up" ]; then
    new_percent=$(echo "$current_percent + 5" | bc)
elif [ "$1" = "down" ]; then
    new_percent=$(echo "$current_percent - 5" | bc)
fi

# Round to nearest multiple of 5
rounded=$(echo "scale=0; (($new_percent + 2.5) / 5) * 5" | bc)

# Cap at 100
[ $(echo "$rounded > 100" | bc) -eq 1 ] && rounded=100
[ $(echo "$rounded < 0" | bc) -eq 1 ] && rounded=0

# Set the volume
wpctl set-volume @DEFAULT_AUDIO_SINK@ "${rounded}%"

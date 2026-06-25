#!/bin/bash

killall -9 waybar
killall -9 swaync

hyprctl reload

waybar &
swaync &

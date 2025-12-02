#!/bin/sh


# Terminate already running bar instances
killall waybar

waybar  &
# waybar -c ~/.config/waybar/config-right.jsonc -s ~/.config/waybar/style-right.css &
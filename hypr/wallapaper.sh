#!/usr/bin/bash
wallpapers=/home/doctor/Wallpapers/wide/
random=$(ls $wallpapers | shuf | head -1)
random=$wallpapers/$random

# split image
magick convert -crop 50%x100% $random /tmp/output.png

swww img -o "DP-1" --transition-type random /tmp/output-0.png
swww img -o "HDMI-A-1" --transition-type random /tmp/output-1.png
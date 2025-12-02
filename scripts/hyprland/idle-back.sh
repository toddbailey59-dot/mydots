#!/usr/bin/bash
sleep 1
# Get the current hour
current_hour=$(date +%H)

# Define the greeting messages
if [ $current_hour -ge 5 ] && [ $current_hour -lt 12 ]; then
    greeting="Good morning! "
    pico2wave -l "en-GB" -w /tmp/greet.wav "Good morning, and welcome back $USER" && paplay /tmp/greet.wav
    notify-send "Good morning, and welcome back $USER"
elif [ $current_hour -ge 12 ] && [ $current_hour -lt 18 ]; then
    greeting="Good afternoon! "
    pico2wave -l "en-GB" -w /tmp/greet.wav "Good afternoon, and welcome back $USER" && paplay /tmp/greet.wav
    notify-send "Good afternoon, and welcome back $USER"
else
    greeting="Good evening!"
    pico2wave -l "en-GB" -w /tmp/greet.wav "Good evening, and welcome back $USER" && paplay /tmp/greet.wav
    notify-send "Good evening, and welcome back $USER" 
fi

# Output the greeting message
echo "$greeting"
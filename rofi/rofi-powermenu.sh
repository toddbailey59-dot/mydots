#!/bin/bash

# Create a temporary file to hold the options
TMPFILE=$(mktemp)

# Define the options
echo "                     Tardis Power Menu" >> $TMPFILE
echo "                        󰍃  Logout" >> $TMPFILE
echo "                          Reboot" >> $TMPFILE
echo "                         Shutdown" >> $TMPFILE
echo "                           Lock" >> $TMPFILE


# Use rofi to display the options
# chosen="$(echo -e "$options" | rofi -lines 5 -dmenu -p "power")"
CHOICE=$(rofi window -width 10% -colunms 1 -lines 5 -dmenu -i -p "Power Menu" < $TMPFILE)

# Execute the chosen option
case "$CHOICE" in
    "󰍃 Logout")
        hyprctl dispatch exit  # Change this if you're using a different window manager
        ;;
    " Reboot")
        systemctl reboot
        ;;
    " Shutdown")
        systemctl poweroff
        ;;
    " Lock")
        hyprlock
        ;;
    *)
        echo "No valid option selected."
        ;;
esac

# Clean up
rm $TMPFILE


#!/bin/bash
#
# Hyprland Keybinds Viewer — clean, floating YAD overlay

CONFIG="$HOME/.config/hypr/hyprland.conf"
TMPFILE=$(mktemp)

# Extract keybinds cleanly
grep -E '^\s*bind' "$CONFIG" | while read -r line; do
    # Remove "bind =" and split by commas
    line=${line#*bind =}
    IFS=',' read -r mod key action rest <<< "$line"

    # Extract comment (optional description)
    desc=$(echo "$line" | sed -n 's/.*#\s*\(.*\)/\1/p')

    # Clean up whitespace
    mod=$(echo "$mod" | xargs)
    key=$(echo "$key" | xargs)
    action=$(echo "$action" | xargs)
    desc=${desc:-"-"}

    # Combine modifier and key
    combo="$mod + $key"

    echo "$combo|$action|$desc"
done > "$TMPFILE"

# Display YAD dialog
yad --title="Tardis Keybindings Cheat Sheet" \
    --width=1300 --height=800 \
    --center \
    --list \
    --no-click \
    --column="Shortcut" --column="Command" --column="Description" \
    --separator="  " \
    --text="Tardis Keybinds Cheat Sheet (from $CONFIG)" \
    --button=Close:0 \
    --undecorated \
    --on-top \
    --skip-taskbar \
    --no-focus \
    --column-alignment=left,left,left \
    --wrap \
    --fixed \
    --window-icon=/usr/share/icons/kora-pgrey/devices/scalable/tardis.png \
    --image=/usr/share/icons/kora-pgrey/devices/scalable/tardis.png \
    --image-on-top < "$TMPFILE"

rm "$TMPFILE"

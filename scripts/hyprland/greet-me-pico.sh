#!/usr/bin/env bash
# ------------------------------------------------------------
# greet-me-pico.sh – Voice greeting using pico2wave
# ------------------------------------------------------------
set -euo pipefail
IFS=$'\n\t'

# ------------------------------------------------------------------
# 1) Temporary file for pico2wave output
# ------------------------------------------------------------------
tmpwav=$(mktemp /tmp/greet-XXXXXX.wav) || {
    echo "❌ Unable to create temporary WAV file" >&2
    exit 1
}

# ------------------------------------------------------------------
# 2) Figure out which part of the day it is
# ------------------------------------------------------------------
hour=$(date +%H)          # 00–23
if [[ $hour -ge 5  && $hour -lt 12 ]]; then
    greeting="morning"
elif [[ $hour -ge 12 && $hour -lt 17 ]]; then
    greeting="afternoon"
elif [[ $hour -ge 17 && $hour -lt 22 ]]; then
    greeting="evening"
else
    greeting="Day"
fi

# ------------------------------------------------------------------
# 3) Get the user’s login name (can be hard‑coded if you like)
# ------------------------------------------------------------------
user_name=$(logname 2>/dev/null || whoami)

# ------------------------------------------------------------------
# 4) Build the sentence that pico2wave will speak
# ------------------------------------------------------------------
if [[ $greeting == "Hi" ]]; then
    spoken="Hi ${user_name}!"
else
    spoken="Good ${greeting}, ${user_name}!"
fi

# ------------------------------------------------------------------
# 5) Generate the WAV file
# ------------------------------------------------------------------
# pico2wave options:
#   -l en : English
#   -w <file> : write output to <file>
pico2wave -l "en-GB" -w "$tmpwav" "$spoken" || {
    echo "❌ pico2wave failed" >&2
    rm -f "$tmpwav"
    exit 1
}

# ------------------------------------------------------------------
# 6) Wait a moment for the audio subsystem to be ready (on boot)
# ------------------------------------------------------------------
sleep 2

# ------------------------------------------------------------------
# 7) Play the file
# ------------------------------------------------------------------
if command -v paplay >/dev/null 2>&1; then
    paplay "$tmpwav" &>/dev/null &
elif command -v aplay >/dev/null 2>&1; then
    aplay "$tmpwav" &>/dev/null &
else
    echo "❌ No audio player (paplay/aplay) found" >&2
fi

# ------------------------------------------------------------------
# 8) Optional: visual notification
# ------------------------------------------------------------------
if command -v notify-send >/dev/null 2>&1; then
    notify-send -i ~/.config/scripts/tardis.svg "$spoken"
fi

# ------------------------------------------------------------------
# 9) Clean up the temporary file when the script exits
# ------------------------------------------------------------------
cleanup() {
    rm -f "$tmpwav"
}
trap cleanup EXIT

# ------------------------------------------------------------------
# 10) Done
# ------------------------------------------------------------------
exit 0
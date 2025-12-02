#!/usr/bin/bash

#Hide cursor
tput civis
#Clear screen
clear

#Get terminal size
rows=$(tput lines)
cols=$(tput cols)

#The Message
msg="Welcome Back Doctor"
pico2wave -w ~/.config/scripts/greet.wav "Welcome back! $USER" && mplayer ~/.config/scripts/greet.wav

#Calculate centered position
msg_len=${#msg}
row_pos=$((rows / 2))
col_pos=$(((cols - msg_len) / 2))

#Move cursor and print message
tput cup $row_pos $col_pos
tput bold italic
echo -e "\e[1;97m$msg\e[0m"
tput sgr0

#Wait then restore cursor
sleep 3
tput cnorm
clear
exit 0
;;
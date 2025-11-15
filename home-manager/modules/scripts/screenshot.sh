#!/bin/bash
folder_name=$(date +%m.%Y)
folder=~/photos/${folder_name}
mkdir -p "$folder"
filename="$folder/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"
XDG_CURRENT_DESKTOP=Sway
flameshot gui -p "$filename" -c
wl-copy < "$filename"
killall flameshot

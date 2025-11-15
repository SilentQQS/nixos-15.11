#!/run/current-system/sw/bin/bash

WALLPAPER=$(find "$HOME/wallpapers" -type f | shuf -n 1)
[ -f "$WALLPAPER" ] && { hyprctl hyprpaper unload all; hyprctl hyprpaper preload "$WALLPAPER"; hyprctl hyprpaper wallpaper "eDP-1,$WALLPAPER"; } || exit 1

#!/run/current-system/sw/bin/bash

DEVICE="asue120b:00-04f3:31c0-touchpad"
STATE_FILE="/tmp/.touchpad_state"

if [ -f "$STATE_FILE" ]; then
    CURRENT_STATE=$(cat "$STATE_FILE")
else
    CURRENT_STATE="enabled"
fi

if [ "$CURRENT_STATE" = "enabled" ]; then
    hyprctl keyword device["$DEVICE"]:enabled 1
    hyprctl keyword device["asue120b:00-04f3:31c0-touchpad"]:sensitivity 0.6
    echo "disabled" > "$STATE_FILE"
    notify-send -t 3000 "Тачпад" "touchpad | 1 |" -i input-touchpad
    echo "touchpad disabled"
else
    hyprctl keyword device["$DEVICE"]:enabled 0
    echo "enabled" > "$STATE_FILE"
    notify-send -t 3000 "Тачпад" "touchpad | 0 |" -i input-touchpad
    echo "touchpad enabled"
fi

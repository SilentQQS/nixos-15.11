#!/run/current-system/sw/bin/bash

options="Shutdown\nReboot\nLock\nHibernate\nSuspend\nLogout"

selected=$(echo -e "$options" | rofi -dmenu -p "Power Menu" -theme-str 'window { width: 20%; height: 250px; } listview { lines: 10; }')

lock_screen() {
	swaylock --color 000000 --text-color=ffffff
}

case $selected in
    Shutdown)
        systemctl poweroff
        ;;
    Reboot)
        systemctl reboot
        ;;
    Lock)
        lock_screen
        ;;
    Hibernate)
        lock_screen & sleep 1 && systemctl hibernate
        ;;
    Suspend)
        lock_screen & sleep 1 && systemctl suspend
        ;;
    Logout)
        hyprctl dispatch exit
        ;;
esac

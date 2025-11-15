#!/run/current-system/sw/bin/bash

# Получаем текущий активный профиль
current_profile=$(powerprofilesctl get)

# Список фиксированных профилей
menu_items=""
for profile in performance balanced power-saver; do
    if [ "$profile" = "$current_profile" ]; then
        menu_items="${menu_items}${profile} [active]\n"
    else
        menu_items="${menu_items}${profile}\n"
    fi
done

# Показываем меню через rofi
selected=$(echo -e "$menu_items" | rofi -dmenu -p "Select Power Profile" -theme-str 'window { width: 20%; height: 250px; } listview { lines: 10; }' | awk '{print $1}')

# Если профиль выбран, переключаем на него
if [ -n "$selected" ]; then
    powerprofilesctl set "$selected"
    notify-send "Power Profile" "Switched to $selected"
fi

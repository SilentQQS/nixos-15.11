#!/bin/bash

# Запускаем приложение
flatpak run org.vinegarhq.Sober &
PID=$!

# Ждём, пока оно завершится
wait $PID

# Убиваем Flatpak процесс (на всякий случай)
flatpak kill org.vinegarhq.Sober 2>/dev/null
pkill -f flatpak-session-helper
pkill -f flatpak-session-helper
pkill -f flatpak-session-helper

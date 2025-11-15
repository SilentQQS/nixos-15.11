#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

# Путь к папке с обоями
DIR="$HOME/wallpapers"

# Настройки перехода для swww
FPS=30
TYPE="simple"
DURATION=3
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION"

# Конфиги для wofi
CONFIG="$HOME/.config/wofi/config"
STYLE="$HOME/.config/wofi/style.css"
COLORS="$HOME/.config/wofi/colors"

# Размер окна wofi в процентах
WIDTH=20
HEIGHT=30

# Функция получения списка изображений
get_pics() {
  # Используем find с учётом расширений, только файлы в DIR (не рекурсивно)
  mapfile -t pics < <(find "$DIR" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.gif' \) -printf '%f\n')
  echo "${pics[@]}"
}

# Функция меню для выбора обоев
menu() {
  local pics=("$@")

  for i in "${!pics[@]}"; do
    # Помечаем gif как анимированные
    if [[ "${pics[$i],,}" == *.gif ]]; then
      echo "$i. ${pics[$i]} (animated)"
    else
      # Показываем имя без расширения для удобства
      echo "$i. ${pics[$i]%.*}"
    fi
  done

  echo "${#pics[@]}. Random wallpaper"
}

# Запуск демона swww, если он не запущен
start_swww_daemon() {
  if ! pgrep -x swww-daemon >/dev/null; then
    swww-daemon &
    # Можно подождать немного, чтобы демон точно запустился
    sleep 0.2
  fi
}

# Основная функция
main() {
  # Получаем список картинок
  mapfile -t PICS < <(get_pics)

  if [ "${#PICS[@]}" -eq 0 ]; then
    echo "No wallpapers found in $DIR" >&2
    exit 1
  fi

  start_swww_daemon

  local RANDOM_PIC_INDEX=$((${#PICS[@]} - 1))  # последний индекс — для random

  local CHOICE=$(menu "${PICS[@]}" | wofi --show dmenu \
    --prompt "Choose wallpaper..." \
    --conf "$CONFIG" --style "$STYLE" --color "$COLORS" \
    --width="$WIDTH%" --height="$HEIGHT%" \
    --cache-file=/dev/null \
    --hide-scroll --no-actions \
    --matching=fuzzy)

  # Если отмена — выйти
  if [ -z "$CHOICE" ]; then
    exit 0
  fi

  local INDEX=${CHOICE%%.*}  # Берём номер выбора

  if [ "$INDEX" -eq "$RANDOM_PIC_INDEX" ]; then
    # Выбрали рандом
    local RANDOM_INDEX=$((RANDOM % RANDOM_PIC_INDEX))
    swww img "$DIR/${PICS[$RANDOM_INDEX]}" $SWWW_PARAMS
  else
    # Выбрали конкретный индекс — проверяем, что индекс валиден
    if [ "$INDEX" -ge 0 ] && [ "$INDEX" -lt "$RANDOM_PIC_INDEX" ]; then
      swww img "$DIR/${PICS[$INDEX]}" $SWWW_PARAMS
    else
      echo "Invalid selection" >&2
      exit 1
    fi
  fi
}

# Если wofi уже запущен — закрываем его
if pgrep -x wofi >/dev/null; then
  pkill wofi
  exit 0
fi

main


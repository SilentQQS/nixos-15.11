#!/usr/bin/env bash

# Класс → Иконка Nerd Font
declare -A icons=(
  ["librewolf"]=""
  ["discord"]="ﭮ"
  ["telegram"]=""
  ["code"]=""
  ["nvim"]=""
  ["kitty"]=""
  ["alacritty"]=""
  ["spotify"]=""
  ["zoom"]=""
  ["obs"]=""
  ["chromium"]=""
  ["google-chrome"]=""
  ["libreoffice"]=""
  ["thunar"]=""
  ["pcmanfm"]=""
  ["steam"]=""
  ["vlc"]=""
  ["mpv"]=""
)

clients=$(hyprctl clients -j)
workspaces=$(hyprctl workspaces -j)

# workspace ID в порядке
all_ws=$(echo "$workspaces" | jq -r 'sort_by(.id) | .[].id')

output=""

for ws in $all_ws; do
    # Список всех окон в этом workspace
    windows=$(echo "$clients" | jq -r --argjson id "$ws" '.[] | select(.workspace.id == $id) | .class')

    # Формируем строку иконок
    icons_line=""
    while read -r class; do
        lower=$(echo "$class" | tr '[:upper:]' '[:lower:]')
        icon="${icons[$lower]}"
        [ -n "$icon" ] && icons_line+="$icon " || icons_line+="⯈ "
    done <<< "$windows"

    output+="${ws}: ${icons_line}  "
done

echo "${output%"  "}"

#!/usr/bin/env bash

DIR="$HOME/wallpapers"

SCRIPT_DIR="$(dirname "$0")"

CONFIG="$SCRIPT_DIR/config"
STYLE="$SCRIPT_DIR/style.css"
COLORS="$SCRIPT_DIR/colors"

wofi_command="wofi --show dmenu \
  --prompt \"current: $(swww query | grep -oP 'image: \K.*' | xargs -n1 basename)\" \
  --conf $CONFIG --style $STYLE --color $COLORS \
  --width=15% --height=70% \
  --cache-file=/dev/null \
  --hide-scroll --no-actions \
  --matching=fuzzy"

current_wallpaper=$(swww query | grep -oP 'image: \K.*' | xargs -n1 basename)

if [[ ! -d "$DIR" ]]; then
  echo "Directory not found: $DIR"
  exit 1
fi

mapfile -t files < <(fd -t f -a . "$DIR")

declare -A filemap
display_names=("0: random")  

index=1

for f in "${files[@]}"; do
  basename=$(basename "$f")
  lowercase_name=$(echo "$basename" | tr '[:upper:]' '[:lower:]')

  if [[ -n "${filemap[$lowercase_name]}" ]]; then
    relpath=$(realpath --relative-to="$DIR" "$f")
    extra_info=$(dirname "$relpath")
    display="$index: $lowercase_name ($extra_info)"
  else
    display="$index: $lowercase_name"
  fi

  display_names+=("$display")
  filemap["$display"]="$f"
  ((index++))
done

chosen=$(printf '%s\n' "${display_names[@]}" | eval "$wofi_command")

[[ -z "$chosen" ]] && exit 1

random_candidates=()
for f in "${files[@]}"; do
  if [[ "$(basename "$f")" != "$current_wallpaper" ]]; then
    random_candidates+=("$f")
  fi
done

if [[ "$chosen" == "0: random" ]]; then
  selected_file="${random_candidates[RANDOM % ${#random_candidates[@]}]}"
else
  selected_file="${filemap[$chosen]}"
fi

swww img "$selected_file" --transition-type any --transition-duration 1 --transition-fps 60

hyprctl notify -1 3000 "rgb(40e0d0)" "$(swww query | grep -oP 'image: \K.*' | xargs -n1 basename)"

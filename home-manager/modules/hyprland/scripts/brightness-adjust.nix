{
  home.file."/.config/hypr/scripts/brightness-adjust.sh" = {
    text = ''
      #!/usr/bin/env bash
      # Аргумент: +step / -step / set:value
      STEP=0.1  # шаг изменения яркости

      STATE_FILE="/tmp/.active_brightness"

      # читаем текущую яркость
      if [ -f "$STATE_FILE" ]; then
        BRIGHTNESS=$(cat "$STATE_FILE")
      else
        BRIGHTNESS=1.0
      fi

      ACTION="$1"

      case "$ACTION" in
        +)
          BRIGHTNESS=$(awk -v b="$BRIGHTNESS" -v s="$STEP" 'BEGIN{print b+s}')
          ;;
        -)
          BRIGHTNESS=$(awk -v b="$BRIGHTNESS" -v s="$STEP" 'BEGIN{print b-s}')
          if (( $(echo "$BRIGHTNESS < 0" | bc -l) )); then
            BRIGHTNESS=0
          fi
          ;;
      set:*)
          BRIGHTNESS=$(echo "$ACTION" | cut -d: -f2)
          ;;
        *)
          echo "Usage: $0 [+|-|set:value]"
          exit 1
          ;;
      esac

      echo "$BRIGHTNESS" > "$STATE_FILE"

      ACTIVE_WIN=$(hyprctl activewindow | awk '/Window/ {print $2}')

      if [ -z "$ACTIVE_WIN" ]; then
        echo "No active window"
        exit 1
      fi

      # Применяем шейдер с динамическим uniform
      hyprctl keyword windowrulev2 "brighten, id:$ACTIVE_WIN"
      hyprctl keyword renderrule "shader:~/.config/hypr/shaders/brighten.frag, uniform:brightness:$BRIGHTNESS"

      echo "Brightness for window $ACTIVE_WIN set to $BRIGHTNESS"
    '';
    executable = true;
  };
}

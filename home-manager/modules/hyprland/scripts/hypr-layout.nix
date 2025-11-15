{
  home.file."/.config/hypr/scripts/hypr-layout.sh" = {
    text = ''
      #!/usr/bin/env sh
      STATE_FILE="/tmp/hypr_layout_state"
      FIFO_FILE="/tmp/waybar-layout.fifo"

      [ ! -p "$FIFO_FILE" ] && mkfifo "$FIFO_FILE"

      apply_state() {
          local layout="$1"

          hyprctl keyword general:layout "$layout"
          echo "$layout" > "$STATE_FILE"
          STATE="$layout"
      }

      if [ "$1" = "toggle" ]; then
          if [ -f "$STATE_FILE" ]; then
              current=$(cat "$STATE_FILE")
              if [ "$current" = "master" ]; then
                  apply_state "dwindle"
              else
                  apply_state "master"
              fi
          else
              apply_state "master"
          fi
      elif [ "$1" = "master" ] || [ "$1" = "dwindle" ]; then
          apply_state "$1"
      else
          if [ -f "$STATE_FILE" ]; then
              STATE=$(cat "$STATE_FILE")
          else
              STATE="dwindle"
          fi
      fi

      timeout 0.1 sh -c "echo '{\"text\":\"$STATE\",\"alt\":\"$STATE\"}' > $FIFO_FILE"
    '';
    executable = true;
  };
}

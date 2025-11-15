{
  home.file."/.config/hypr/scripts/otter-launcher.sh" = {
    text = ''
      #!/usr/bin/env bash

      if pgrep -x "otter-launcher" >/dev/null; then
          pkill -f "$TERMINAL.*otter-launcher"
          exit 0
      fi

      $TERMINAL --app-id otter-launcher -T otter-launcher -e sh -c 'otter-launcher' &
      # hyprctl dispatch exec "[workspace special:otter] $TERMINAL_CMD" &

      if hyprctl devices | rg "keymap" | grep -q "Russian"; then
          hyprctl switchxkblayout kanata next
      fi
    '';
    executable = true;
  };
}

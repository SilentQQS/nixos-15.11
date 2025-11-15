{
  home.file."/.config/hypr/scripts/otter-apprunner.sh" = {
    text = ''
      #!/usr/bin/env bash

      if pgrep -f "launcher-app" >/dev/null; then
          pkill -f "$TERMINAL.*launcher-app"
          exit 0
      fi

      $TERMINAL --app-id otter-apprunner -T otter-apprunner --font "monospace:size=14" -e sh -c '$HOME/.config/otter-launcher/scripts/launcher-app.sh purge && $HOME/.config/otter-launcher/scripts/launcher-app.sh' &

      if hyprctl devices | rg "keymap" | grep -q "Russian"; then
          hyprctl switchxkblayout kanata next
      fi
    '';
    executable = true;
  };
}

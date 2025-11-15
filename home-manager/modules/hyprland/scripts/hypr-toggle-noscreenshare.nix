{
  home.file."/.config/hypr/scripts/hypr-toggle-noscreenshare.sh" = {
    text = ''
      #!/usr/bin/env bash

      CONFIG_FILE="$HOME/.config/hypr/hypr-noscreenshare.conf"
      STATE_FILE="/tmp/.noscreenshare_state"
      FIFO_FILE="/tmp/noscreenshare.fifo"
      ARG="$1"

      [ ! -p "$FIFO_FILE" ] && mkfifo "$FIFO_FILE"

      if [ ! -f "$CONFIG_FILE" ]; then
        mkdir -p "$(dirname "$CONFIG_FILE")"
        cat > "$CONFIG_FILE" <<'EOF'
      windowrulev2 = noscreenshare,class:^(com.ayugram.desktop)$
      windowrulev2 = noscreenshare,class:chromium-browser
      windowrulev2 = noscreenshare,class:obsidian
      EOF
      fi

      apply_state() {
        local state="$1"
        if [ "$state" = "allow" ]; then
          sed -i 's/^#\+//g' "$CONFIG_FILE"
          rm -f "$STATE_FILE"
          STATE="on"
        else
          sed -i '/windowrulev2.*noscreenshare/ s/^\([^#]\)/#\1/' "$CONFIG_FILE"
          touch "$STATE_FILE"
          STATE="off"
        fi

        # hyprctl reload
      }

      if [ "$ARG" = "toggle" ]; then
        if [ -f "$STATE_FILE" ]; then
          apply_state "allow"
        else
          apply_state "deny"
        fi
      elif [ "$ARG" = "allow" ] || [ "$ARG" = "deny" ]; then
        apply_state "$ARG"
      else
        if [ -f "$STATE_FILE" ]; then
          STATE="off"
        else
          STATE="on"
        fi
      fi

      timeout 0.1 sh -c "echo '{\"text\":\"$STATE\",\"alt\":\"$STATE\"}' > $FIFO_FILE"
    '';
    executable = true;
  };
}

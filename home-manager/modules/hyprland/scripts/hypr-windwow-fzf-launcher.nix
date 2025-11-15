{
  home.file."/.config/hypr/scripts/hypr-window-fzf-launcher.sh" = {
    text = ''
      #!/usr/bin/env bash

      if pgrep -af window-launcher >/dev/null; then
          pkill --signal TERM -f window-launcher
          exit 0
      fi

      $TERMINAL --app-id window-launcher -T window-launcher --font "monospace:size=14" -e sh -c '~/.config/hypr/scripts/hypr-window-fzf.sh' &

      if hyprctl devices | rg "keymap" | grep -q "Russian"; then
          hyprctl switchxkblayout kanata next
      fi
    '';
    executable = true;
  };

  home.file."/.config/hypr/scripts/hypr-window-fzf.sh" = {
    text = ''
      #!/usr/bin/env bash

      windows_json=$(hyprctl clients -j)
      if [ -z "$windows_json" ]; then
          hyprctl notify 1 5000 "rgb(d20f39)" "NO WINDOW"
          exit 1
      fi

      windows_list=$(echo "$windows_json" | jq -r '.[] | [.class, .title, .address] | @tsv' | column -t -s$'\t')

      selected=$(echo "$windows_list" | fzf \
          --prompt="Choose window > " \
          --header="CLASS                TITLE" \
          --delimiter=$'\t' \
          --with-nth=1,2 \
          --ansi \
          --cycle \
          --border rounded \
          --preview-window=down:3:hidden \
          --bind 'ctrl-/:toggle-preview' \
          --bind 'enter:accept' \
          --preview 'echo -e "\033[1mCLASS:\033[0m {1}\n\033[1mTITLE:\033[0m {2}"')

      [ -z "$selected" ] && exit 0

      address=$(echo "$selected" | awk '{print $NF}')

      workspace=$(hyprctl clients -j | jq -r ".[] | select(.address==\"$address\") | .workspace.id")
      hyprctl dispatch workspace "$workspace" >/dev/null 2>&1
      hyprctl dispatch focuswindow address:"$address" >/dev/null 2>&1
    '';
    executable = true;
  };
}

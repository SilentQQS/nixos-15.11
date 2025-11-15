{
  home.file."/.config/hypr/scripts/hypr-toggle-cursor-invisible.sh" = {
    text = ''
      #!/usr/bin/env sh
      if hyprctl -j getoption cursor:invisible | grep -q '"int": 1'; then
        hyprctl keyword cursor:invisible false
        hyprctl notify 1 5000 "rgb(40a02b)" "Cursor [ON]"
      else
        hyprctl keyword cursor:invisible true
        hyprctl notify 1 5000 "rgb(d20f39)" "Cursor [OFF]"
      fi
    '';
    executable = true;
  };
}

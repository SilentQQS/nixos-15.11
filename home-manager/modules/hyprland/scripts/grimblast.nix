{
  home.file."/.config/hypr/scripts/grimblast.sh" = {
    text = ''
      #!/usr/bin/env sh

      set -e

      trap 'hyprctl keyword cursor:invisible false; ~/.config/hypr/scripts/hypr-toggle-noscreenshare.sh allow' EXIT

      hyprctl keyword cursor:invisible true &&
      sleep 0.05 &&
      ~/.config/hypr/scripts/hypr-toggle-noscreenshare.sh deny &&
      sleep 0.03 &&
      mkdir -p "$XDG_SCREENSHOTS_DIR" &&
      SLURP_ARGS="-w 4 -d -b #00000040 -c #29B6F699 -s #42A5F530 -B #00000060" grimblast --notify --freeze copy area - # or copysave area
      sleep 0.2 &&
      hyprctl keyword cursor:invisible false

      if pgrep hyprpicker >/dev/null 2>&1; then
          pkill -9 hyprpicker
          pkill -9 grimblast
      elif pgrep grimblast >/dev/null 2>&1; then
          pkill -9 hyprpicker
          pkill -9 grimblast
      fi
    '';
    executable = true;
  };
}

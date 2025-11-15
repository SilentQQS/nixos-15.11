{
  home.file."/.config/hypr/scripts/grimwsatty.sh" = {
    text = ''
      #!/usr/bin/env sh

      set -e

      trap '~/.config/hypr/scripts/hypr-toggle-noscreenshare.sh allow' EXIT

      ~/.config/hypr/scripts/hypr-toggle-noscreenshare.sh deny &&
      sleep 0.03 &&
      mkdir -p "$XDG_SCREENSHOTS_DIR" &&
      SLURP_ARGS="-w 4 -d -b #00000040 -c #29B6F699 -s #42A5F530 -B #00000060" grimblast --notify --freeze save area - | # or copysave area
      satty \
        --copy-command "wl-copy" \
        -f - \
        --output-filename "$XDG_SCREENSHOTS_DIR/m_$(date +%Y-%m-%d__%H-%M-%S____%3N).png" \
        --save-after-copy \
        --early-exit \
        --corner-roundness 0
    '';
    executable = true;
  };
}

{
  home.file."/.config/hypr/scripts/hypr-opacity.sh" = {
    text = ''
      #!/usr/bin/env bash

      step=0.05
      min=0.1
      max=1.0

      current=$(hyprctl getoption decoration:active_opacity -j | jq -r '.float')

      case "$1" in
        up)
          new=$(awk -v v="$current" -v s="$step" -v m="$max" 'BEGIN{v+=s; if(v>m)v=m; print v}')
          icon="🔼"
          ;;
        down)
          new=$(awk -v v="$current" -v s="$step" -v n="$min" 'BEGIN{v-=s; if(v<n)v=n; print v}')
          icon="🔽"
          ;;
        *)
          notify-send -a "Hyprland" "Opacity" "Использование: opacity.sh [up|down]"
          exit 1
          ;;
      esac

      hyprctl keyword decoration:active_opacity "$new"
      hyprctl keyword decoration:inactive_opacity "$new"

      # notify-send -a "Hyprland" "Opacity $icon" "Текущее значение: $new"
      hyprctl notify 1 700 0 "Opacity $icon: $new"

    '';
    executable = true;
  };
}

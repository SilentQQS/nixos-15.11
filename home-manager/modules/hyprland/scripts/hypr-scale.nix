{
  home.file."/.config/hypr/scripts/hypr-scale.sh" = {
    text = ''
      #!/usr/bin/env bash

      step=0.25
      min=0.5
      max=1.5

      monitor=$(hyprctl activeworkspace -j | jq -r '.monitor')
      current=$(hyprctl monitors -j | jq -r ".[] | select(.name==\"$monitor\") | .scale")

      case "$1" in
        up)
          new=$(awk -v v="$current" -v s="$step" -v m="$max" 'BEGIN{v+=s; if(v>m)v=m; printf "%.2f", v}')
          icon="🔎➕"
          ;;
        down)
          new=$(awk -v v="$current" -v s="$step" -v n="$min" 'BEGIN{v-=s; if(v<n)v=n; printf "%.2f", v}')
          icon="🔎➖"
          ;;
        *)
          notify-send -a "Hyprland" "Scale" "Used: hypr-scale.sh [up|down]"
          exit 1
          ;;
      esac

      hyprctl keyword "monitor $monitor,preferred,auto,$new"

      # notify-send -a "Hyprland" "Scale $icon" "Scale: $new"
      hyprctl notify 1 1700 0 "Scale $icon: $new"


    '';
    executable = true;
  };
}

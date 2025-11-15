{unstablePkgs, ...}: {
  xdg.configFile."waybar/scripts" = {
    source = ./scripts;
    recursive = true;
    executable = true;
  };

  programs.waybar = {
    enable = true;
    package = unstablePkgs.waybar;
    style = ./style.css;
    settings = {
      mainBar = {
        position = "top";
        margin-top = 0;
        margin-left = 0;
        margin-right = 0;
        height = 26;

        modules-left = [
          "hyprland/workspaces"
          "custom/hyprlayout"
          "hyprland/window"
          # "hyprland/submap"
          # "workspace-taskbar"
          # "hyprland/windowcount"
        ];

        modules-center = [
          "hyprland/language"
          "clock"
          "systemd-failed-units"
          "custom/noscreenshare"
          "wireplumber#source"
          # "gamemode"
        ];

        modules-right = [
          "privacy"
          "bluetooth"
          "pulseaudio"
          "load"
          "cpu"
          "memory"
          "custom/swapon"
          "network"
          "custom/network_speed"
          "temperature#cpu"
          "temperature#gpu"
          "temperature#gpu2"
          "backlight"
          "power-profiles-daemon"
          "battery"
          "tray"
        ];

        "hyprland/window" = {
          format = "{}";
          icon = false;
          icon-size = 22;
          max-length = 28;
          # rewrite = {
          #   "" = "";
          # };
          separate-outputs = true;
          swap-icon-label = false;
        };

        "hyprland/submap" = {
          format = "✌️ {}";
          max-length = 8;
          tooltip = false;
        };

        "hyprland/workspaces" = {
          format = "{icon}:[{windows}]";
          format-window-swparator = "";
          on-click = "activate";
          sort-by-number = true;
          persistent-workspaces = {
            "*" = 1;
          };
          show-special = true;
          # special-visible-only = true;
          swap-icon-label = false;
          workspace-taskbar = {
            enable = true;
            update-active-window = false;
            format = "{icon}";
            # format = "{icon} {title:.3}";
            icon-size = 20;
            icon-theme = "some_icon_theme";
            orientation = "horizontal";
            # ignore-list = [ code; Firefox - .* ];
            workspace-taskbar-on-click-window = ''
              if [ {button} -eq 1 ]; then
                hyprctl keyword cursor:no_warps true
                hyprctl dispatch focuswindow address:{address}
                hyprctl keyword cursor:no_warps false
              fi
            '';
          };
        };

        "hyprland/language" = {
          format = "{}";
          format-en = "<span color='#4CC9F0'>US</span>";
          format-ru = "<span color='#F28482'>RU</span>";
          # keyboard-name = "kanata"; # kanata or at-translated-set-2-keyboard || !!IF USE KANATA COMMENT THIS TEXT !!
        };

        "hyprland/windowcount" = {
          format = "[{}]";
          format-empty = "[X]";
          format-windowed = "[{}]";
          format-fullscreen = "[{}]";
          separate-outputs = true;
        };

        clock = {
          interval = 1;
          format = "{:%H:%M:%S(%a.%d.%m)}";
          format-alt = "{:%H:%M:%S(%a.%d.%m.%B)}";
          tooltip = false;
        };

        cpu = {
          interval = 1;
          format = "<span color='#F8961E'>{icon}  {usage}%</span>";
          format-icons = [
            ""
            #   "<span color='#69ff94'>\'</span>"
            #   "<span color='#2aa9ff'>\'</span>"
            #   "<span color='#f8f8f2'>\'</span>"
            #   "<span color='#f8f8f2'>\'</span>"
            #   "<span color='#ffffa5'>\'</span>"
            #   "<span color='#ffffa5'>\'</span>"
            #   "<span color='#ff9977'>\'</span>"
            #   "<span color='#dd532e'>\'</span>"
          ];
        };

        "load" = {
          interval = 1;
          format = "<span color='#A0AEC0'>{load1}</span> <span color='#8194B8'>{load5}</span> <span color='#6B7D9C'>{load15}</span>";
        };

        memory = {
          interval = 5;
          # format = "<span color='#7FD86C'>{icon}  {percentage}({swapPercentage})%</span>";
          format = "<span color='#7FD86C'>{icon}  {percentage}%</span>";
          format-icons = [""];
        };

        "custom/swapon" = {
          "exec" = "~/.config/waybar/scripts/swapon_usage.sh";
          "interval" = 5;
          "format" = "<span color='#7FD86C'>{}</span>";
          "tooltip" = false;
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "<span color='#FFFFFF'>{capacity}</span>";
          format-full = "<span color='#00FF00'>{capacity}</span>";
          format-charging = "<span color='#00FFFF'>{capacity}</span>";
          format-plugged = "<span color='#00FFFF'>{capacity}</span>";
          format-discharging = "<span color='#4FF96D'>{capacity}% ({time})</span>";
          format-time = "<span color='#FFFFFF'>{H}h {M}m</span>";
          interval = 5;
        };

        "power-profiles-daemon" = {
          format = "{icon}";
          format-icons = {
            default = "<span color='#69ff94'>▁</span>";
            performance = "<span color='#dd532e'>█</span>";
            balanced = "<span color='#ffffa5'>▅</span>";
            power-saver = "<span color='#69ff94'>▁</span>";
          };
          swap-icon-label = false;
        };

        network = {
          interval = 10;
          tooltip = false;
          interface = "wlan0";
          format-alt = "{ipaddr}/{cidr}|{signalStrength}%";
          format-wifi = "{signalStrength}%";
          format-ethernet = "{cidr}";
          format-linked = "{ifname} (No IP)";
          format-disconnected = " Err_Net ";
        };

        "bluetooth" = {
          format = " {status}";
          format-connected = " {}";
          format-connected-battery = "<span color='#339CFF'> {device_battery_percentage}%</span>";
          format-device-preference = ["device1" "device2"];
          tooltip = false;
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = " {volume}%";
          # format-bluetooth = "{volume}% {icon}  {format_source}";
          # format-bluetooth-muted = " {icon} {format_source}";
          format-icons = {
            "alsa_output.usb-Jieli_Technology_USB_Composite_Device_4250315730373118-00.analog-stereo" = "";
            "bluez_output.69_C2_BE_C5_94_AB.1" = "";
            "USB Composite Device Analog Stereo-muted" = "";
            "default" = ["" ""];
          };
          on-click = "foot --title pulsemixer pulsemixer";
          on-click-middle = "~/.config/hypr/scripts/wpctl-audio-tumbler.sh";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          scroll-step = 1;
          ignored-sinks = ["Easy Effects Sink"];
          swap-icon-label = false;
        };

        "wireplumber#source" = {
          "node-type" = "Audio/Source";
          format = "<span color='#69ff94'size='15000'>󰍬</span>";
          "format-muted" = "<span color='#ff5555'size='15000'>󰍭</span>";
          "on-click-right" = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          "scroll-step" = 2;
          "tooltip-format" = "{volume}%";
        };

        "backlight" = {
          interval = 30;
          device = "amdgpu_bl1";
          format = "{icon}";
          tooltip-format = "{percent}%";
          format-icons = [
            "<span color='#A020F0'>󰃜</span>"
            "<span color='#A020F0'>󰃝</span>"
            "<span color='#FFD700'>󰃠</span>"
            "<span color='#FFD700'>󰃚</span>"
          ];
          # format-icons = ["󰃜" "󰃝" "󰃠" ""];
        };

        privacy = {
          icon-spacing = 4;
          icon-size = 16;
          swap-icon-label = false;
          transition-duration = 250;
          modules = [
            {
              type = "screenshare";
              tooltip = true;
              tooltip-icon-size = 24;
            }
            {
              type = "audio-out";
              tooltip = true;
              tooltip-icon-size = 24;
            }
            {
              type = "audio-in";
              tooltip = true;
              tooltip-icon-size = 24;
            }
          ];
        };

        "systemd-failed-units" = {
          hide-on-ok = true;
          format = "{nr_failed}";
          system = true;
          # user = false;
        };

        "temperature#cpu" = {
          hwmon-path-abs = "/sys/devices/pci0000:00/0000:00:18.3/hwmon";
          input-filename = "temp1_input";
          format = "<span color='#F4C7C3'>{temperatureC}°</span>";
          critical-threshold = 80;
          format-critical = "<span color='#EF476F'>{temperatureC}°C <U+F2C7></span>";
          interval = 5;
          tooltip-format = "CPU: {temperatureC}°C";
        };

        "temperature#gpu" = {
          hwmon-path-abs = "/sys/devices/pci0000:00/0000:00:08.1/0000:64:00.0/hwmon";
          input-filename = "temp1_input";
          format = "<span color='#F4C7C3'>{temperatureC}°</span>";
          critical-threshold = 75;
          format-critical = "<span color='#EF476F'>{temperatureC}°C <U+F2C7></span>";
          interval = 5;
          tooltip-format = "GPU: {temperatureC}°C";
        };

        "temperature#gpu2" = {
          hwmon-path-abs = "/sys/class/hwmon/hwmon4";
          input-filename = "temp1_input";
          format = "<span color='#8FD19E'>{temperatureC}°</span>";
          critical-threshold = 75;
          format-critical = "<span color='#EF476F'>{temperatureC}°C <U+F2C7></span>";
          interval = 5;
          tooltip-format = "NVIDIA_GPU: {temperatureC}°C";
        };

        "tray" = {
          show-passive-items = true;
          icon-size = 18;
          swap-icon-label = false;
          spacing = 8;
        };

        "custom/network_speed" = {
          # exec = "~/.config/waybar/scripts/netspeed.sh";
          exec = "$HOME/.config/waybar/scripts/netrxtx.sh";
          interval = 0;
          format = "<span color='#FFD166'>{}</span>";
          tooltip = false;
        };

        # "custom/noscreenshare" = {
        #   "exec" = "~/.config/hypr/scripts/hypr-toggle-noscreenshare.sh";
        #   "on-click" = "~/.config/hypr/scripts/hypr-toggle-noscreenshare.sh toggle && pkill -SIGRTMIN+4 waybar";
        #   "signal" = 4;
        #   "interval" = "once";
        #   "return-type" = "json";
        #   "format" = "{icon}";
        #   "format-icons" = {
        #     "off" = "";
        #     "on" = " 󰗹";
        #   };
        #   "tooltip" = false;
        # };

        "custom/noscreenshare" = {
          "exec" = "sh -c '$HOME/.config/hypr/scripts/hypr-toggle-noscreenshare.sh >/dev/null 2>&1; ($HOME/.config/hypr/scripts/hypr-toggle-noscreenshare.sh >/dev/null 2>&1) & tail -f /tmp/noscreenshare.fifo'";
          "on-click" = "$HOME/.config/hypr/scripts/hypr-toggle-noscreenshare.sh toggle";
          "interval" = "0";
          "return-type" = "json";
          "format" = "{icon}";
          "format-icons" = {
            "off" = "  ";
            "on" = " 󰗹 ";
          };
          "tooltip" = false;
        };

        "custom/hyprlayout" = {
          "exec" = "sh -c '$HOME/.config/hypr/scripts/hypr-layout.sh >/dev/null 2>&1; ($HOME/.config/hypr/scripts/hypr-layout.sh >/dev/null 2>&1) & tail -f /tmp/waybar-layout.fifo'";
          "on-click" = "$HOME/.config/hypr/scripts/hypr-layout.sh toggle";
          "interval" = 0;
          "format" = "{icon}";
          "return-type" = "json";
          "format-icons" = {
            "master" = "<span color='#C2E2FA'>[M]</span>";
            "dwindle" = "<span color='#C2E2FA'>[D]</span>";
          };
          "tooltip" = false;
        };

        # "gamemode" = {
        #   format = "{glyph}";
        #   format-alt = "{glyph} {count}";
        #   glyph = "";
        #   hide-not-running = false;
        #   use-icon = true;
        #   icon-name = "input-gaming-symbolic";
        #   icon-spacing = 4;
        #   icon-size = 20;
        #   tooltip = true;
        #   tooltip-format = "Games running = {count}";
        # };
      };
    };
  };
}

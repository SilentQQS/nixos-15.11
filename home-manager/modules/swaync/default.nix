{
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      control-center-width = 500;
      control-center-height = 600;
      control-center-margin-top = 12;
      control-center-margin-bottom = 12;
      control-center-margin-right = 12;
      control-center-margin-left = 12;
      control-center-radius = 10;
      fit-to-screen = true;
      layer-shell = true;
      layer = "overlay";
      control-center-layer = "overlay";
      cssPriority = "user";
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      notification-window-width = 450;
      keyboard-shortcut = false;
      image-visibility = "when-available";
      transition-time = 30;

      widgets = [
        "inhibitors"
        "buttons-grid"
        "volume"
        "backlight"
        "title"
        "dnd"
        "mpris"
        "notifications"
      ];

      widget-config = {
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "Clear All";
        };
        dnd = {
          text = "Do Not Disturb";
          show-status = true;
        };
        mpris = {
          image-size = 96;
          blur = true;
          show-player = true;
          show-progress = true;
        };
        volume = {
          label = "󰕾 ";
          expand-button-label = " ";
          collapse-button-label = " ";
          show-per-app = true;
          show-per-app-icon = true;
          show-per-app-label = false;
        };
       backlight = {
            label = "󰃟 ";
            device = "amdgpu_bl1";
            max = "brightnessctl -d amdgpu_bl1 m";
            update-command = "brightnessctl -d amdgpu_bl1 g";
            change-command = "brightnessctl -d amdgpu_bl1 s %s%%";
        };
        buttons-grid = {
          actions = [
            {
              label = " ";
              type = "toggle";
              active = false;
              command = "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && pulsemixer --id $(pulsemixer --list-sources | awk -F: \"/Default/ {print \$1}\") --mute || pulsemixer --id $(pulsemixer --list-sources | awk -F: \"/Default/ {print \$1}\") --unmute'";
              update-command = "sh -c 'pulsemixer --list-sources | grep -q \"[on]\" && echo false || echo true'";
            }
            {
              label = " ";
              type = "toggle";
              active = false;
              command = "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && pulsemixer --mute || pulsemixer --unmute'";
              update-command = "sh -c 'pulsemixer --get-mute | grep -q 1 && echo true || echo false'";
            }
          ];
        };
        inhibitors = {
          show-application-name = true;
          show-reason = true;
          show-buttons = true;
        };
      };
    };

    style = ''
    * {
      font-family: "Fira Sans", sans-serif;
      font-size: 14px;
      color: rgba(255, 255, 255, 0.87);
    }

    .notification {
      background: rgba(30, 34, 42, 0.75);
      border-radius: 10px;
      border: 1px solid #444;
      padding: 10px;
      margin: 1px 1px;
    }

    .notification.low {
      border-left: 4px solid #88c0d0;
    }

    .notification.normal {
      border-left: 4px solid #FFCC00;
    }

    .notification.critical {
      border-left: 4px solid #bf616a;
    }
y
    .control-center {
      background: rgba(30, 34, 42, 0.85);
      border-radius: 12px;
      border: 1px solid #444;
      padding: 16px;
    }

    .widget-title {
      font-size: 16px;
      font-weight: bold;
      margin-bottom: 8px;
      color: #eceff4;
    }

    .widget-dnd, .widget-inhibitors, .widget-mpris {
      background: rgba(40, 44, 52, 0.5);
      padding: 10px;
      margin: 6px 0;
      border-radius: 8px;
    }

    .widget-mpris .player {
      background: transparent;
    }

    .button {
      background-color: rgba(76, 86, 106, 0.3);
      border-radius: 6px;
      padding: 6px 10px;
      color: #d8dee9;
    }

    .button:hover {
      background-color: rgba(76, 86, 106, 0.5);
    }
  '';
  };
}
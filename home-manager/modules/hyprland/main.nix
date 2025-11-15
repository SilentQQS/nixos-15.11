{unstablePkgs, ...}: {
  home.file.".config/hypr/xdph.conf".text = ''
    screencopy {
      max_fps = 144
      allow_token_by_default = true
    }
  '';

  # home.file.".config/hypr/shaders.conf" = {
  #   text = ''
  #     decoration:screen_shader=/home/fotom/.config/hypr/shaders/brighten.frag
  #   '';
  # };

  wayland.windowManager.hyprland = {
    enable = true;
    package = unstablePkgs.hyprland;
    plugins = [
      # pkgs.hyprlandPlugins.hyprexpo
      # unstablePkgs.hyprlandPlugins.hyprscrolling
      # unstablePkgs.hyprlandPlugins.hypr-dynamic-cursors
      # unstablePkgs.hyprlandPlugins.hyprspace
    ];
    systemd.enable = false;
    settings = {
      env = [
        "WLR_RENDERER,vulkan"
        "AQ_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0"
        "AQ_FORCE_LINEAR_BLIT,0"
        "AQ_MGPU_NO_EXPLICIT,1"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "LIBVA_DRIVER_NAME,nvidia"
        "WLR_DRM_NO_ATOMIC,1"
        "WLR_DRM_NO_MODIFIERS,1"
        "NIXOS_OZONE_WL,1"
        "NVD_BACKEND,direct"
        "MOZ_WEBRENDER,1"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_QPA_PLATFORM,wayland"
        "QT_QPA_PLATFORMTHEME,gtk3"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"

        "XDG_SCREENSHOTS_DIR,$HOME/screens"
      ];

      monitor = "eDP-1,1920x1080@144,0x0,1";
      # monitor="eDP-1,transform,1";
      "$mainMod" = "SUPER";
      # "$terminal" = "foot -e sh -c \"tmux\"";
      "$terminal" = "foot";
      # "$fileManager" = "$terminal -e sh -c 'yazi'";
      "$fileManager" = "$terminal -e fish -i -c 'yy; exec fish'";
      # "$menu" = "pgrep -x otter-launcher >/dev/null && pkill -x otter-launcher || $terminal --app-id otter-launcher -T otter-launcher -e sh -c \"sleep 0.05 && otter-launcher\"";
      # "$menu" = "pgrep -x otter-launcher >/dev/null && pkill -x otter-launcher || hyprctl dispatch exec [ workspace special:otter ] \"$TERMINAL --app-id otter-launcher -T otter-launcher -H -e sh -c \'while true; do otter-launcher; done\'\" & hyprctl devices | rg \"keymap\" | grep -q \"Russian\" && hyprctl switchxkblayout kanata next";
      "$menu" = "~/.config/hypr/scripts/otter-launcher.sh";
      "$apprunner" = "~/.config/hypr/scripts/otter-apprunner.sh";

      "$browser" = "chromium";

      exec-once = [
        "sleep 1 && waybar"
        # "sleep 0.2 && swww init"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "wl-clip-persist --clipboard regular --selection-size-limit 1048576"
        "wl-clip-persist --clipboard primary --selection-size-limit 1048576"

        "hyprctl keyword device[\"asue120b:00-04f3:31c0-touchpad\"]:enabled 0"
        "dbus-update-activation-environment --all"
        "sleep 0.4 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "sleep 0.6 && easyeffects --gapplication-service"
        "sleep 0.1 && hyprctl setcursor Bibata-Modern-Classic 16"
        "sleep 0.2 && wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1" # Disable micro
        "sleep 0.7 && systemctl --user start hyprpolkitagent"

        "sleep 1.2 && ayugram-desktop"
        "sleep 0.9 && $browser"
        # "obsidian"
      ];

      gestures = {
        # workspace_swipe = true;
        workspace_swipe_distance = 700;
        # workspace_swipe_fingers = 3;
        # workspace_swipe_min_fingers = true;
        workspace_swipe_cancel_ratio = 0.2;
        workspace_swipe_min_speed_to_force = 5;
        workspace_swipe_direction_lock = true;
        workspace_swipe_direction_lock_threshold = 10;
        workspace_swipe_create_new = true;
      };

      general = {
        gaps_in = 3;
        gaps_out = 3;
        gaps_workspaces = 50;

        border_size = 2;

        # "col.active_border" = "rgba(9EC6F3ee)";
        "col.inactive_border" = "rgba(595959aa)";
        "col.active_border" = "rgba(0DB7D4FF)";
        # "col.inactive_border" = "rgba(31313600)";

        resize_on_border = true;
        no_focus_fallback = true;
        allow_tearing = true;

        snap = {
          enabled = true;
        };

        layout = "dwindle"; #master/dwindle
      };

      cursor = {
        inactive_timeout = 2;
        zoom_factor = 1;
        zoom_rigid = false;
      };

      decoration = {
        rounding = 7;

        active_opacity = 1;
        inactive_opacity = 1;
        # active_opacity = 0.89;
        # inactive_opacity = 0.89;
        #  dim_inactive = true;
        #  dim_strength = 0.025;
        #  dim_special = 0.07;

        shadow = {
          enabled = false;
          ignore_window = true;
          range = 30;
          offset = "0 2";
          render_power = 4;
          color = "rgba(00000010)";
        };

        blur = {
          enabled = false;
          xray = true;
          special = false;
          new_optimizations = true;
          size = 14;
          passes = 3;
          brightness = 1;
          noise = 0.01;
          contrast = 1;
          popups = true;
          popups_ignorealpha = 0.6;
          input_methods = true;
          input_methods_ignorealpha = 0.8;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "expressiveFastSpatial, 0.42, 1.67, 0.21, 0.90"
          "expressiveSlowSpatial, 0.39, 1.29, 0.35, 0.98"
          "expressiveDefaultSpatial, 0.38, 1.21, 0.22, 1.00"
          "emphasizedDecel, 0.05, 0.7, 0.1, 1"
          "emphasizedAccel, 0.3, 0, 0.8, 0.15"
          "standardDecel, 0, 0, 0, 1"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.52, 0.03, 0.72, 0.08"
        ];
        animation = [
          "windowsIn, 1, 3, emphasizedDecel, popin 80%"
          "windowsOut, 1, 2, emphasizedDecel, popin 90%"
          "windowsMove, 1, 3, emphasizedDecel, slide"
          "border, 1, 10, emphasizedDecel"
          "layersIn, 1, 2.7, emphasizedDecel, popin 93%"
          "layersOut, 1, 2.4, menu_accel, popin 94%"
          "fadeLayersIn, 1, 0.5, menu_decel"
          "fadeLayersOut, 1, 2.7, menu_accel"
          "workspaces, 1, 7, menu_decel, slide"
          "specialWorkspaceIn, 1, 2.8, emphasizedDecel, slidevert"
          "specialWorkspaceOut, 1, 1.2, emphasizedAccel, slidevert"
        ];
      };

      input = {
        kb_layout = "us,ru";
        kb_options = "grp:alt_shift_toggle"; # grp:caps_toggle
        follow_mouse = 1;
        sensitivity = -0.6;
        repeat_delay = 190;
        repeat_rate = 70;

        touchpad = {
          natural_scroll = "yes";
          disable_while_typing = true;
          clickfinger_behavior = true;
          scroll_factor = 0.5;
        };
      };

      #  gestures = {
      #    workspace_swipe = true;
      #    workspace_swipe_invert = true;
      #    workspace_swipe_forever	= true;
      #  };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "slave";
        new_on_top = true;
        mfact = 0.5;
      };

      group = {
        "col.border_active" = "rgba(ae75daff)";
        "col.border_inactive" = "rgba(9112bcff)";
        "col.border_locked_active" = "rgba(ea2264ff)";
        "col.border_locked_inactive" = "rgba(ea2264ff)";

        groupbar = {
          enabled = true;
          font_size = 14;
          font_weight_active = "bold";
          font_weight_inactive = "normal";
          indicator_gap = 2;
          indicator_height = 0;
          text_offset = 0;
          scrolling = true;
          rounding = 10;
          round_only_edges = true;
          gradient_rounding = 6;
          gradient_round_only_edges = true;
          gradients = true;
          text_color = "0xffffffff";
          "col.active" = "rgba(4d2d8cff)";
          "col.inactive" = "rgba(212121ff)";
          "col.locked_active" = "rgba(8c1007ff)";
          "col.locked_inactive" = "rgba(212121ff)";
          height = 16;
          gaps_in = 3;
          gaps_out = 3;
          keep_upper_gap = true;
          stacked = false;
          render_titles = true;
          priority = 3;
        };
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
        enforce_permissions = true;
      };

      permission = [
        # Screencopy
        "/nix/store/[a-z0-9]{32}-grim-[0-9.]*/bin/grim, screencopy, allow"
        "/nix/store/[a-z0-9]{32}-hyprpicker-[0-9.]*/bin/hyprpicker, screencopy, allow"

        "\${lib.getExe pkgs.grim}, screencopy, allow"

        # Plugins
        "/nix/store/[a-z0-9]{32}-hypr-dynamic-cursors-[^/]*/lib/libhypr-dynamic-cursors\.so, plugin, allow"
      ];

      windowrulev2 = [
        "workspace 10 silent,class:(obsidian)"
        "workspace 9,class:(com.obsproject.Studio)"
        "workspace 5 silent,class:(io.github.tdesktop_x64.TDesktop)"
        "workspace 5 silent,class:(com.ayugram.desktop)"
        "workspace 8,class:(goofcord)"

        # For $terminal --title cliphist cliphist-fzf-sixel
        "float, title:^(cliphist)$"
        "pin, title:^(cliphist)$"
        "keepaspectratio, title:^(cliphist)$"
        # "move 73% 72%, title:^(cliphist)$"
        "size 75%, title:^(cliphist)$"

        # # Noscreenshare   EDIT THIS IN SCRIPT AND EXPORT SOURCE BUTTOM
        # "noscreenshare, class:^(com.ayugram.desktop)$"
        # "noscreenshare, class:floorp"
        # "noscreenshare, class:obsidian"

        # Group

        # Tag
        # "tag +term, class:foot"
        # "bordercolor rgb(a4b0be), tag:term*"

        # Customize window
        "bordercolor 0xFF00FA9A,fullscreenstate:* 1"
        "bordersize 2,fullscreenstate:* 1"
        "bordercolor 0xFFDAA520,floating:1"
        # "bordercolor rgba(FF6F61EE) rgba(FF6F61EE) 45deg rgba(FF6F61EE) rgba(FF6F61EE) 45deg, pinned:1"
        "bordercolor rgba(FF6F61EE), pinned:1"

        "bordercolor rgb(0078ff),workspace:name:special:S"
        "bordercolor rgb(6c5ce7),workspace:name:special:D"
        "bordercolor 0xFF00FA9A,fullscreenstate:* 1,workspace:name:special:S"
        "bordercolor 0xFF00FA9A,fullscreenstate:* 1,workspace:name:special:D"

        # "bordercolor rgba(FF6F61EE),floating:1,workspace:name:special:otter"

        # fix some problem with Xwayland
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

        "opacity 0.0 override, class:^(xwaylandvideobridge)$"
        "noanim, class:^(xwaylandvideobridge)$"
        "noinitialfocus, class:^(xwaylandvideobridge)$"
        "maxsize 1 1, class:^(xwaylandvideobridge)$"
        "noblur, class:^(xwaylandvideobridge)$"
        "nofocus, class:^(xwaylandvideobridge)$"

        # Picture-in-Picture
        "float, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
        "keepaspectratio, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
        "move 73% 72%, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
        "size 25%, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
        "float, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"
        "pin, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$"

        "float, title:^(Picture in picture)$"
        "pin, title:^(Picture in picture)$"
        "keepaspectratio, title:^(Picture in picture)$"
        "move 73% 72%, title:^(Picture in picture)$"
        "size 25%, title:^(Picture in picture)$"

        # Dialog windows – float+center these windows.
        "center, title:^(Open File)(.*)$"
        "center, title:^(Choose Files)(.*)$"
        "center, title:^(Select a File)(.*)$"
        "center, title:^(Choose wallpaper)(.*)$"
        "center, title:^(Open Folder)(.*)$"
        "center, title:^(Save As)(.*)$"
        "center, title:^(Library)(.*)$"
        "center, title:^(File Upload)(.*)$"
        "center, title:^(Media viewer)$"
        "float, title:^(Open File)(.*)$"
        "float, title:^(Choose Files)(.*)$"
        "float, title:^(Select a File)(.*)$"
        "float, title:^(Choose wallpaper)(.*)$"
        "float, title:^(Open Folder)(.*)$"
        "float, title:^(Save As)(.*)$"
        "float, title:^(Library)(.*)$"
        "float, title:^(File Upload)(.*)$"
        "float, title:^(Media viewer)$"

        # --- Tearing ---
        "immediate, title:.*\.exe"
        "immediate, title:.*minecraft.*"
        "immediate, class:^(steam_app)"

        # No shadow for tiled windows
        "noshadow, floating:0"

        "opacity 1, class:^(goofcord)$"
      ];
      windowrule = [
        "float, title:^(htop)$"
        "size 1400 900, title:^(htop)$"
        "float, title:^(btop)$"
        "size 1800 1000, title:^(btop)$"
        "float, title:^(swaylock)$"
        "size 900 900, title:^(swaylock)$"
        "float, title:^(pulsemixer)$"
        "move 900 28, title:^(pulsemixer)$"
        "size 956 450, title:^(pulsemixer)$"
        "pin, title:^(pulsemixer)$"
        "float, class:^(com\\.obsproject\\.Studio)$"
        "size 458 738, class:^(com\\.obsproject\\.Studio)$"
        "float, title:^(MainPicker)$"
        "size 256 450, title:^(MainPicker)$"
        "size 85%, class:^com\.gabm\.satty$"

        "float, class: otter-launcher"
        "float, class: window-launcher"
        "float, class: otter-apprunner"
        "center(1), class: otter-launcher"
        "center(1), class: window-launcher"
        "center(1), class: otter-apprunner"
        "size 539 325, class: otter-launcher"
        "size 885, 713, class: window-launcher"
        "size 900 590, class: otter-apprunner"
        "stayfocused, class: otter-launcher"
        "stayfocused, class: window-launcher"
        "stayfocused, class: otter-apprunner"
        "pin, class: otter-launcher"
        "pin, class: window-launcher"
        "pin, class: otter-apprunner"
        "nomaxsize, class: otter-launcher"
      ];
      # workspace = [
      #   "w[tv1], gapsout:0, gapsin:0"
      #   "f[1], gapsout:0, gapsin:0"
      # ];

      binds = {
        scroll_event_delay = 10;
      };

      bind = [
        "$mainMod,       A, exec, $terminal"
        "$mainMod,       Q, killactive"
        "$mainMod,       M, exit"
        "$mainMod SHIFT, E, exec, $fileManager"
        "$mainMod,       V, togglefloating"
        "$mainMod,       B, exec, $browser"
        "$mainMod,       P, pin"
        "$mainMod,       Z, togglesplit"
        "$mainMod,       F, fullscreen"
        "$mainMod,       W, fullscreen, 1" #maximize
        # "$mainMod,       E, exec, bemoji -cn"
        # "$mainMod CTRL,  B, exec, pkill -SIGUSR2 waybar"
        "$mainMod,       T, exec, pkill -SIGUSR1 waybar" # Hide/Show waybar
        "$mainMod CTRL,  T, exec, pkill waybar & sleep 0.2 && waybar" # Restart waybar
        "$mainMod,       I, exec, loginctl lock-session & notify-send \"lock\""
        # "$mainMod,       P, exec, hyprpicker -an"
        ", Print, exec, pgrep slurp >/dev/null 2>&1 || $HOME/.config/hypr/scripts/grimblast.sh"
        "CTRL, Print, exec, pgrep slurp >/dev/null 2>&1 || $HOME/.config/hypr/scripts/grimwsatty.sh"

        "WIN, F1, exec, $HOME/.config/hypr/scripts/hypr-gamemode.sh"
        "WIN, F2, exec, $HOME/.config/hypr/scripts/hypr-toggle-cursor-invisible.sh"
        "$mainMod SHIFT, grave, exec, $HOME/.config/hypr/scripts/hypr-layout.sh toggle"
        "$mainMod CTRL, grave, exec, $HOME/.config/hypr/scripts/hypr-toggle-noscreenshare.sh toggle"
        "$mainMod, N, exec, swaync-client -t"
        "$mainMod, R, exec, $menu"
        "$mainMod, E, exec, $apprunner"
        "$mainMod SHIFT, W, exec, ~/.config/hypr/scripts/hypr-window-fzf-launcher.sh"
        # "$mainMod CTRL, R, exec, /etc/nixos/home-manager/modules/scripts/swww_wofi/swww_wofi_changer.sh"
        "$mainMod CTRL, P, pseudo" #dwindle
        "$mainMod SHIFT, R,layoutmsg, movetoroot active unstable" #move to root

        # Moving focus
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        # Moving windows on other workspace
        "$mainMod SHIFT, h,  swapwindow, l"
        "$mainMod SHIFT, j, swapwindow, d"
        "$mainMod SHIFT, k,    swapwindow, u"
        "$mainMod SHIFT, l,  swapwindow, r"

        # Move floating window
        "$mainMod ALT, h, moveactive, -10 0"
        "$mainMod ALT, l, moveactive,  10 0"
        "$mainMod ALT, k, moveactive,  0 -10"
        "$mainMod ALT, j, moveactive,  0  10"

        # Resizeing windows               X  Y
        "$mainMod CTRL, h, resizeactive, -10 0"
        "$mainMod CTRL, l, resizeactive,  10 0"
        "$mainMod CTRL, k, resizeactive,  0 -10"
        "$mainMod CTRL, j, resizeactive,  0  10"

        # Switching workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # "$mainMod CTRL, 1, workspace, 11"
        # "$mainMod CTRL, 2, workspace, 12"
        # "$mainMod CTRL, 3, workspace, 13"
        # "$mainMod CTRL, 4, workspace, 14"
        # "$mainMod CTRL, 5, workspace, 15"
        # "$mainMod CTRL, 6, workspace, 16"
        # "$mainMod CTRL, 7, workspace, 17"
        # "$mainMod CTRL, 8, workspace, 18"
        # "$mainMod CTRL, 9, workspace, 19"
        # "$mainMod CTRL, 0, workspace, 20"

        # Moving windows to workspaces
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # "$mainMod CTRL SHIFT, 1, movetoworkspace, 11"
        # "$mainMod CTRL SHIFT, 2, movetoworkspace, 12"
        # "$mainMod CTRL SHIFT, 3, movetoworkspace, 13"
        # "$mainMod CTRL SHIFT, 4, movetoworkspace, 14"
        # "$mainMod CTRL SHIFT, 5, movetoworkspace, 15"
        # "$mainMod CTRL SHIFT, 6, movetoworkspace, 16"
        # "$mainMod CTRL SHIFT, 7, movetoworkspace, 17"
        # "$mainMod CTRL SHIFT, 8, movetoworkspace, 18"
        # "$mainMod CTRL SHIFT, 9, movetoworkspace, 19"
        # "$mainMod CTRL SHIFT, 0, movetoworkspace, 20"

        # Grouped (tabbed)
        "$mainMod,                 G, togglegroup"
        "$mainMod CTRL,  bracketleft, changegroupactive, b"
        "$mainMod CTRL, bracketright, changegroupactive, f"
        "$mainMod CTRL,            G, lockactivegroup, toggle"
        "$mainMod SHIFT,           G, moveoutofgroup" # move un group

        # Scratchpad
        "$mainMod,       S, togglespecialworkspace,  S"
        "$mainMod SHIFT, S, movetoworkspace, special:S"
        "$mainMod,       D, togglespecialworkspace,  D"
        "$mainMod SHIFT, D, movetoworkspace, special:D"

        # Workspace e-1/e+1
        "$mainMod, bracketleft, workspace, e-1"
        "$mainMod, bracketright, workspace, e+1"
        "ALT, S, workspace, e-1"
        "ALT, D, workspace, e+1"

        # Opacity changer
        "$mainMod, comma, exec, ~/.config/hypr/scripts/hypr-opacity.sh down"
        "$mainMod, period, exec, ~/.config/hypr/scripts/hypr-opacity.sh up"

        # Zoom
        "$mainMod, mouse_down, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')"
        "$mainMod, mouse_up, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')"

        "$mainMod, equal, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')"
        "$mainMod, minus, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')"
        "$mainMod, KP_ADD, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')"
        "$mainMod, KP_SUBTRACT, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')"

        "$mainMod SHIFT, mouse_up, exec, hyprctl -q keyword cursor:zoom_factor 1"
        "$mainMod SHIFT, mouse_down, exec, hyprctl -q keyword cursor:zoom_factor 1"
        "$mainMod SHIFT, minus, exec, hyprctl -q keyword cursor:zoom_factor 1"
        "$mainMod SHIFT, KP_SUBTRACT, exec, hyprctl -q keyword cursor:zoom_factor 1"

        # Scale window
        "$mainMod CTRL, comma, exec, ~/.config/hypr/scripts/hypr-scale.sh down"
        "$mainMod CTRL, period, exec, ~/.config/hypr/scripts/hypr-scale.sh up"

        # Cursed stuff
        "$mainMod CTRL, Backslash, resizeactive, exact 1029 628"

        # "$mainMod CTRL, T, exec, foot --title \"htop\" htop"
        "$mainMod CTRL, W, exec, $terminal --title \"btop\" btop"

        # "$mainMod CTRL, L, exec, foot --title \"swaylock\" --hold /etc/nixos/home-manager/modules/scripts/logout.sh"

        # Cliphist-term
        "$mainMod, X, exec, hyprctl clients | grep -q \"title: cliphist\" && pkill -f cliphist-fzf || $terminal --title cliphist cliphist-fzf-sixel"
      ];

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Laptop multimedia keys for volume and LCD brightness
      bindel = [
        ",XF86AudioRaiseVolume,  exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+"
        ",XF86AudioLowerVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
        ",XF86AudioMute,         exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute,      exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp,   exec, brightnessctl s 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 5%-"
        ",XF86TouchpadToggle,    exec, /etc/nixos/home-manager/modules/scripts/toggle_touchpad.sh"
        # ",XF86WebCam, exec, ~/.config/hypr/scripts/wpctl-audio-tumbler.sh"
      ];

      # Audio playback
      bindl = [
        ", XF86AudioNext,  exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay,  exec, playerctl play-pause"
        ", XF86AudioPrev,  exec, playerctl previous"
      ];
    };
    extraConfig = ''
      source = ~/.config/hypr/hypr-noscreenshare.conf
      source = ~/.config/hypr/hypr-plugins.conf
      # source = ~/.config/hypr/shaders.conf

    '';
  };
}

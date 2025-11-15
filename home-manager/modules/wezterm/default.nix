{pkgs, ...}: {
  programs.wezterm = {
    enable = true;
    package = pkgs.wezterm;

    extraConfig = ''
      local wezterm = require("wezterm")

      return {
        color_scheme = "Oxocarbon Dark (Gogh)",
        enable_wayland = true,
        window_background_opacity = 1,
        hide_tab_bar_if_only_one_tab = true,

        font = wezterm.font("BigBlueTermPlus Nerd Font Mono", { weight = "Regular" }),
        font_size = 10.0,
        line_height = 1.0,

        enable_tab_bar = true,
        use_fancy_tab_bar = false,
        window_padding = {
          left = 0, right = 0, top = 0, bottom = 0,
        },

        scrollback_lines = 10000,
        check_for_updates = false,

        default_cursor_style = "BlinkingBlock",
        cursor_blink_rate = 700,

        keys = {
          { key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
          { key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
          { key = "Enter", mods = "ALT", action = "ToggleFullScreen" },
          { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
          { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
        },
      }
    '';
  };
}

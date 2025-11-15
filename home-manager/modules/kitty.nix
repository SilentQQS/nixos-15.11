{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.kitty = {
    enable = true;
    font = {
      name = lib.mkForce "BigBlueTermPlus Nerd Font Mono";
      size = lib.mkForce 10;
    };

    settings = {
      cursor_trail = 1;

      dynamic_background_opacity = "yes";
      dynamic_width = "no";
      dynamic_height = "no";
      window_padding_width = "0";
      confirm_os_window_close = 0;

      enable_audio_bell = "no";
      clipboard_control = "write-clipboard write-primary read-clipboard read-primary";

      scrollback_lines = 10000;
      wheel_scroll_multiplier = 3.0;

      bold_font = "auto";
      italic_font = "auto";
      disable_ligatures = "never";

      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "round";
      tab_title_template = "{index}: {title}";

      input_delay = 2;
      repaint_delay = 8;
      remember_window_size = "no";
      initial_window_width = 1200;
      initial_window_height = 750;
      sync_to_monitor = "yes";
    };

    keybindings = {
      "ctrl+shift+t" = "new_tab_with_cwd";
      "ctrl+shift+w" = "close_tab";
      "ctrl+shift+tab" = "previous_tab";
      "ctrl+tab" = "next_tab";

      "ctrl+shift+enter" = "new_window";
      "ctrl+shift+left" = "move_window left";
      "ctrl+shift+right" = "move_window right";
      "ctrl+shift+up" = "move_window up";
      "ctrl+shift+down" = "move_window down";

      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+s" = "paste_from_selection";

      "ctrl+equal" = "increase_font_size";
      "ctrl+minus" = "decrease_font_size";
      "ctrl+0" = "reset_font_size";
    };
  };
}

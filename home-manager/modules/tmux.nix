{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    package = pkgs.tmux;
    newSession = false;
    baseIndex = 1;
    clock24 = true;
    mouse = true;
    escapeTime = 0;
    keyMode = "vi";
    terminal = "tmux-256color";
    # terminal = "screen-256color";
    shell = "${pkgs.fish}/bin/fish";
    historyLimit = 10000;
    focusEvents = true;
    plugins = with pkgs; [
      # tmuxPlugins.resurrect
      # tmuxPlugins.continuum
      tmuxPlugins.catppuccin
    ];
    prefix = "C-b";
    resizeAmount = 5;
    reverseSplit = false;
    secureSocket = true;
    sensibleOnTop = false;
    shortcut = "b"; # CTRL + b
    tmuxinator.enable = false;
    tmuxp.enable = false;
    customPaneNavigationAndResize = false;
    disableConfirmationPrompt = true;
    extraConfig = ''
      set -g @catppuccin_flavor 'latte' # latte, frappe, macchiato or mocha
      set -g @catppuccin_window_status_style "none"
      set -g @catppuccin_date_time_text "%d-%m %H:%M"
      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-left ""

      set -gF  status-right "#{@catppuccin_status_directory}"
      set -agF status-right "#{@catppuccin_status_host}"
      set -agF status-right "#{E:@catppuccin_status_date_time}"
      set -ag status-right "#{E:@catppuccin_status_session}"
      set -ag status-right "#{E:@catppuccin_status_uptime}"
    '';
  };
}

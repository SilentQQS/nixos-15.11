{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = ./theme.rasi;

    extraConfig = {
      modi = "calc,drun,ssh,window";
      combi-modi = "window,drun";
      show-icons = true;
      terminal = "${pkgs.foot}/bin/foot";
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "apps";
      sidebar-mode = true;
    };

    plugins = [ pkgs.rofi-calc ]; 
  };
}


{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    eww
  ];

  xdg.configFile."eww" = {
    source = ./assets;
    recursive = true;
  };

  xdg.configFile."eww/scripts" = {
    source = ./scripts;
    recursive = true;
    executable = true;
  };
}

{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.stylix.homeModules.stylix];

  home.packages = with pkgs; [
    # dejavu_fonts
    noto-fonts
    # font-awesome
    nerd-fonts.bigblue-terminal
  ];

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/classic-dark.yaml";

    targets = {
      neovim.enable = false;
      waybar.enable = false;
      rofi.enable = false;
      wofi.enable = false;
      mako.enable = false;
      swaync.enable = false;
      firefox.enable = false;
      floorp.enable = false;
      spicetify.enable = false;
      starship.enable = false;
      hyprland.enable = false;
      hyprlock.enable = false;
      swaylock.enable = false;
      fish.enable = false;
      wezterm.enable = false;
      yazi.enable = false;
      bat.enable = false;
    };

    cursor = {
      name = "Bibata-Modern-Classic";
      size = 16;
      package = pkgs.bibata-cursors;
    };

    opacity = {
      terminal = 1.0;
      applications = 1.0;
    };

    fonts = {
      monospace = {
        name = "BigBlueTerm437 Nerd Font";
        package = pkgs.nerd-fonts.bigblue-terminal;
      };
      sansSerif = {
        name = "Noto Sans";
        package = pkgs.noto-fonts;
      };
      serif = {
        name = "Noto Serif";
        package = pkgs.noto-fonts;
      };

      sizes = {
        terminal = 13;
        applications = 11;
      };
    };
  };
}

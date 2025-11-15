{pkgs, ...}: {
  xdg.portal = {
    enable = true;
    # config.common.default = "hyprland";
    #   config = {
    #     common = {
    #       default = "gtk";
    #       "org.freedesktop.impl.portal.FileChooser" = "gtk";
    #     };
    #   };
    # };
    #   xdg.portal.wlr.enable = true;
    #   xdg.portal.extraPortals = with pkgs; [
    #     xdg-desktop-portal-gtk
    #   # # xdg-desktop-portal-hyprland
    #   ];
  };
}

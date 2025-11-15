{pkgs, ...}: {
  gtk = {
    enable = true;

    iconTheme = {
      name = "Whitesur-dark";
      package = pkgs.whitesur-icon-theme;
    };
  };

  xdg.enable = true;
}

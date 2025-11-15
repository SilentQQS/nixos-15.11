{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    kdePackages.plasma-workspace
    kdePackages.plasma-desktop
    kdePackages.dolphin
  ];

  programs.uwsm.waylandCompositors = {
    kde = {
      prettyName = "KDE Plasma 6 (UWSM)";
      comment = "Plasma 6 Wayland session managed by UWSM";
      binPath = "${pkgs.kdePackages.plasma-workspace}/bin/startplasma-wayland";
    };
  };
}

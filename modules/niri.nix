{unstablePkgs, ...}: {
  programs.niri = {
    enable = true;
    package = unstablePkgs.niri;
  };
  programs.uwsm.waylandCompositors = {
    niri = {
      prettyName = "Niri (UWSM)";
      comment = "A dynamic, non-tiling Wayland compositor managed by UWSM";
      binPath = "${unstablePkgs.niri}/bin/niri";
    };
  };
}

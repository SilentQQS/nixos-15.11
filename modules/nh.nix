{unstablePkgs, ...}: {
  programs.nh = {
    enable = true;
    package = unstablePkgs.nh;
    flake = "/etc/nixos";
    clean.enable = true;
    clean.extraArgs = "--keep-since 10d --keep 10";
  };
}

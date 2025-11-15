{ pkgs, ... }:

let
  flameshotWithGrim = pkgs.flameshot.overrideAttrs (oldAttrs: {
    cmakeFlags = (oldAttrs.cmakeFlags or []) ++ [ "-DUSE_WAYLAND_GRIM=ON" ];
  });
in
{
  home.packages = [
    flameshotWithGrim
  ];
}


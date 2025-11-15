{ config, pkgs, lib, user, ... }: {
  environment.systemPackages = with pkgs; [
    helix
    nixd
    alejandra
  ];

}


{ config, pkgs, ... }:

let
  fzfOverlay = self: super: {
    fzf = super.fzf.overrideAttrs (oldAttrs: {
      postInstall = ''
        ${oldAttrs.postInstall or ""}
        rm -f $out/share/fish/vendor_conf.d/load-fzf-key-bindings.fish || true
      '';
    });
  };
in {
  nixpkgs.overlays = [ fzfOverlay ];

  home.packages = with pkgs; [
    fzf
  ];

}


{
  pkgs,
  user,
  ...
}: let
  customIconPath = ./icon.png;
in {
  home.file = {
    ".config/ayugram/icon.png".source = customIconPath;
  };

  home.packages = [pkgs.ayugram-desktop];

  nixpkgs.overlays = [
    (self: super: {
      ayugram-desktop = super.ayugram-desktop.overrideAttrs (oldAttrs: {
        postInstall = ''
          ${oldAttrs.postInstall or ""}
            substituteInPlace $out/share/applications/com.ayugram.desktop.desktop \
              --replace "Icon=ayugram" "Icon=/home/${user}/.config/ayugram/icon.png"
        '';
      });
    })
  ];
}

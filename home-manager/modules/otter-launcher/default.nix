{pkgs, ...}: {
  home.packages = [
    (pkgs.rustPlatform.buildRustPackage {
      pname = "otter-launcher";
      version = "0.5.8";
      src = ./otter-launcher;
      cargoLock = {
        lockFile = ./otter-launcher/Cargo.lock;
      };
    })
    pkgs.chafa # required for render image
    pkgs.krabby # for pakemon in launcher
  ];

  home.file.".config/otter-launcher/config.toml" = {
    source = ./otter-launcher/config/config.toml;
  };

  xdg.configFile."otter-launcher/scripts" = {
    source = ./scripts;
    recursive = true;
    executable = true;
  };
}

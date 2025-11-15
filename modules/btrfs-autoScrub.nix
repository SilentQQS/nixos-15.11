{
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = ["/" "/home" "/nix"];
  };
}

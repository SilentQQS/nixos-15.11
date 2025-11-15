{
  pkgs,
  user,
  ...
}: {
  programs.fish.enable = true;
  programs.command-not-found.enable = false;

  users = {
    defaultUserShell = pkgs.fish;
    users.${user} = {
      isNormalUser = true;
      extraGroups = ["wheel" "input" "video" "audio" "networkmanager" "docker" "wireshark" "libvirtd" "kvm"];
    };
  };

  #  services.getty.autologinUser = user;
}

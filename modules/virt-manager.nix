{pkgs, ...}: {
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    # win-virtio
    # win-spice
  ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        # swtpm.enable = true; # for TPM 2.0
        # ovmf.enable = true; # for Window UEFI
        # ovmf.packages = [pkgs.OVMFFull.fd]; # for Windows UEFI
        runAsRoot = false;
      };
    };
    # spiceUSBRedirection.enable = true;
  };

  services.spice-vdagentd.enable = true;

  security.polkit.enable = true;
}

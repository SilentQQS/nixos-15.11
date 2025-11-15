{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    impala
  ];
  networking.useNetworkd = true;
  services.resolved.enable = true;
  networking.wireless.iwd.enable = true;
  networking.networkmanager.enable = false;

  systemd.network.networks."10-wired" = {
    matchConfig.Name = "en*";
    networkConfig.DHCP = "yes";
  };

  services.resolved.extraConfig = ''
    DNS=1.1.1.1 1.0.0.1 2606:4700:4700::1111 2606:4700:4700::1001
    FallbackDNS=8.8.8.8 8.8.4.4
    DNSOverTLS=yes
  '';
}

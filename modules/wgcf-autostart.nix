{
  config,
  pkgs,
  user,
  ...
}: {
  systemd.services.warpon = {
    description = "Warpon auto-start (wgcf-profile)";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.wireguard-tools}/bin/wg-quick up /home/${user}/.config/wgcf/wgcf-profile.conf";
      # ExecStop = "${pkgs.wireguard-tools}/bin/wg-quick down /home/%u/.config/wgcf/wgcf-profile.conf";
      # RemainAfterExit = true;
    };
  };
}

{
  config,
  pkgs,
  ...
}: let
  wgcfProfilePath = "${config.xdg.configHome}/wgcf/wgcf-profile.conf";
in {
  home.packages = with pkgs; [wgcf wireguard-tools];

  home.file."${wgcfProfilePath}" = {
    text = ''
      [Interface]
      PrivateKey = OKyKK5F8JSU4GyhKCxWsuwqp37eV8Bq8XAvvm86EbH0=
      Address = 172.16.0.2/32, 2606:4700:110:852f:be01:a479:c84a:bbe1/128
      # DNS = 1.1.1.1, 1.0.0.1, 2606:4700:4700::1111, 2606:4700:4700::1001
      MTU = 1280
      [Peer]
      PublicKey = bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=
      AllowedIPs = 0.0.0.0/0, ::/0
      Endpoint = engage.cloudflareclient.com:2408    '';
    force = true;
    # mode = "0600";x
  };
}

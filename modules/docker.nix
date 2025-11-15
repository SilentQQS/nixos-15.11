{
  config,
  pkgs,
  ...
}: {
  virtualisation.docker.enable = true;
  hardware.nvidia-container-toolkit.enable = true;
  virtualisation.docker.package = pkgs.docker;

  virtualisation.docker.daemon.settings = {
    "runtimes" = {
      nvidia = {
        path = "${pkgs.nvidia-container-toolkit}/bin/nvidia-container-runtime";
      };
    };
  };

  # systemd.services."nvidia-container-toolkit-cdi-generator" = {
  #   serviceConfig = {
  #     TimeoutStopSec = "5s";
  #     KillMode = "mixed";     # kill proc if zombi
  #   };
  # };

  virtualisation.docker.daemon.settings = {
    userland-proxy = false;
    experimental = true;
    metrics-addr = "127.0.0.1:9323";
    ipv6 = true;
    fixed-cidr-v6 = "fd00::/80";
  };
}

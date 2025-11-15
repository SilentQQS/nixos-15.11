{pkgs, ...}: {
  systemd.services.battery-charge-threshold = {
    description = "Set battery charge threshold";
    wantedBy = ["multi-user.target" "suspend.target" "hibernate.target" "hybrid-sleep.target" "resume.target"];
    after = ["suspend.target" "hibernate.target" "hybrid-sleep.target" "resume.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.runtimeShell} -c 'if [ -w /sys/class/power_supply/BAT0/charge_control_end_threshold ]; then echo 45 > /sys/class/power_supply/BAT0/charge_control_end_threshold; fi'";
    };
  };
}

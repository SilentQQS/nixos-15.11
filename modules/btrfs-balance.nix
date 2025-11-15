{pkgs, ...}: {
  # Балансировка раз в месяц
  systemd.services."btrfs-balance" = {
    description = "Monthly Btrfs balance";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.btrfs-progs}/bin/btrfs balance start -dusage=75 -musage=75 /";
      Nice = 19;
      IOSchedulingClass = "idle";
      ConditionPathIsMountPoint = "/";
    };
  };

  systemd.timers."btrfs-balance" = {
    description = "Run Btrfs balance monthly";
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "monthly";
      Persistent = true;
    };
  };
}

{pkgs, ...}: {
  # Дефрагментация /home раз в месяц
  systemd.services."btrfs-defrag-home" = {
    description = "Monthly Btrfs defragmentation for /home";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.btrfs-progs}/bin/btrfs filesystem defragment -r -v -czstd /home";
      Nice = 19;
      IOSchedulingClass = "idle";
    };
  };

  systemd.timers."btrfs-defrag-home" = {
    description = "Run Btrfs defrag on /home monthly";
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "monthly";
      Persistent = true;
    };
  };
}

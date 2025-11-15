{ pkgs, ... }:
{
  systemd.user.timers.notifyReminder = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "30min";
      OnUnitActiveSec = "30min";
      Unit = "notifyReminder.service";
    };
    enable = true;
  };

  systemd.user.services.notifyReminder = {
    description = "Send a notification every 30 minutes";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.libnotify}/bin/notify-send '⏰ Напоминание' 'Прошлo ещё 30 минут!'";
      Environment = "DISPLAY=:0 WAYLAND_DISPLAY=wayland-0 XDG_RUNTIME_DIR=/run/user/1000";
    };
  };
}


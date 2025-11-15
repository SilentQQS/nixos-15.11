{pkgs, ...}: {
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    polkit_gnome
  ];
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
  environment.etc."polkit-1/rules.d/49-authkeep.rules".text = ''
    polkit.addRule(function(action, subject) {
        if (subject.isInGroup("wheel")) {
            return polkit.Result.AUTH_SELF_KEEP;
        }
    });
  '';

  systemd.tmpfiles.rules = [
    "w /etc/polkit-1/rules.d/49-authkeep.rules 0644 root root -"
  ];
}

{
  config,
  pkgs,
  ...
}: {
  security.lsm = ["apparmor"];
  security.apparmor.enable = true;
  services.dbus.apparmor = "enabled";
  security.apparmor.includes = {
    "abstractions/gui-sandbox-local" = ''
      /nix/store/** mr,
      /etc/** r,

      /run/user/*/wayland-* rw,
      /tmp/.X11-unix/* rw,
      /run/user/*/pulse/** rw,
      /run/user/*/pipewire-0 rw,
      /proc/self/** r,

      deny /proc/*/mem rw,
      deny /proc/*/task/** rw,
      deny /proc/*/fd/** w,
    '';
  };
  security.apparmor.policies.ayugram-desktop = {
    state = "enforce"; # enforce / complain
    profile = ''
      #include <tunables/global>
      #include <tunables/home>

      profile gui-sandbox.ayugram-desktop /nix/store/*-ayugram-desktop-*/bin/ayugram-desktop {
        include <abstractions/gui-sandbox-local>

        /nix/store/*-ayugram-desktop-*/bin/.ayugram-desktop-wrapped ix,

        /home/fotom/.local/share/AyuGramDesktop/** rwk,
        /home/fotom/.local/share/AyuGramDesktop/ rw,

        /home/fotom/.cache/fontconfig/** rwk,

        /home/fotom/Downloads/** rw,
        /home/fotom/Downloads/ rw,

        /home/fotom/.config/dconf/user rw,
        /run/user/1000/dconf/user rw,

        network inet,
        network inet6,

        /proc/sys/vm/overcommit_memory r,
        /sys/kernel/mm/transparent_hugepage/enabled r,
        /proc/filesystems r,

        /dev/tty r,
        /dev/urandom r,
        /proc/*/mounts r,
        /proc/*/status r,
        /proc/stat r,
        /sys/devices/system/node/ r,
        /sys/devices/system/cpu/possible r,
        /sys/devices/system/cpu/online r,

        /tmp/** rwk,
        /tmp/* mkl,

        /home/fotom/.local/share/AyuGramDesktop/** wl,

      }
    '';
  };
}

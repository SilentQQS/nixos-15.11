{pkgs, ...}: {
  programs.fastfetch = {
    enable = true;
    package = pkgs.fastfetch;
  };

  home.file.".config/fastfetch/otter.jsonc".text = ''
    {
      "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
      "logo": {
        "source": "$(fastfetch.sh logo)",
        "height": 14
      },
      "display": {
        "separator": " : "
      },
      "modules": [
        { "type": "break" },
        { "type": "colors" },
        { "type": "break" },
        { "type": "os" },
        { "type": "kernel" },
        { "type": "uptime" },
        { "type": "DateTime" },
        {
          "type": "command",
          "key": "󱦟: OS Age ",
          "text": "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days=$((time_progression / 86400)); hours=$(( (time_progression % 86400) / 3600 )); minutes=$(( (time_progression % 3600) / 60 )); echo \"$days days, $hours hours, $minutes minutes\""
        },
      ],
      "keyType": "icon"
    }

  '';

  home.file.".config/fastfetch/3x5070.jsonc".text = ''
            {
              "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
              "logo": {
                "source": "$(fastfetch.sh logo)",
                "height": 14
              },
              "modules": [

      "title",
       "separator",

      {
        "type": "custom",
        "format": "NixOS 25.05 (Warbler) x86_64",
        "key": "OS",
        "keyColor": "cyan"
      },
      {
        "type": "custom",
        "format": "Linux 6.16.5-gentoo-dist",
        "key": "Kernel",
        "keyColor": "cyan"
      },
      {
        "type": "custom",
        "format": "4 hours, 51 mins",
        "key": "Uptime",
        "keyColor": "cyan"
      },
      {
        "type": "custom",
        "format": "2181 (nix-system), 19280 (nix-user), 47 (flatpak)",
        "key": "Packages",
        "keyColor": "cyan"
      },
      {
        "type": "custom",
        "format": "Bash 5.2.57",
        "key": "Shell",
        "keyColor": "cyan"
      },
      {
        "type": "custom",
        "format": "3840x2160 @ 144 Hz",
        "key": "Display",
        "keyColor": "cyan"
      },
      {
        "type": "custom",
        "format": "Hyprland 0.50.1 (Wayland)",
        "key": "WM",
        "keyColor": "cyan"
      },
      {
        "type": "custom",
        "format": "Breeze",
        "key": "WM Theme",
        "keyColor": "cyan"
      },
      {
        "type": "custom",
        "format": "Breeze (Dark) [Qt], Breeze-Dark [GTK2], Breeze [GTK3]",
        "key": "Theme",
        "keyColor": "cyan"
      },
      {
        "type": "custom",
        "format": "breeze-dark [Qt], breeze-dark [GTK2/3/4]",
        "key": "Icons",
        "keyColor": "cyan"
      },
      {
        "type": "custom",
        "format": "Noto Sans [10pt] (Qt), Noto Sans [10pt] [GTK2/3/4]",
        "key": "Font",
        "keyColor": "cyan"
      },
      {
        "type": "custom",
        "format": "foot 1.22.3",
        "key": "Terminal",
        "keyColor": "cyan"
      },
      {
        "type": "custom",
        "format": "AMD Ryzen 7 9800X3D (16) @ 5.71 GHz",
        "key": "CPU",
        "keyColor": "cyan"
      },
      {
        "type": "custom",
        "format": "NVIDIA GeForce RTX 5080 [Discrete]",
        "key": "GPU 0",
        "keyColor": "cyan"
      },
      {
        "type": "custom",
        "format": "NVIDIA GeForce RTX 5080 [Discrete]",
        "key": "GPU 1",
        "keyColor": "cyan"
      },
      {
        "type": "custom",
        "format": "NVIDIA GeForce RTX 5080 [Discrete]",
        "key": "GPU 2",
        "keyColor": "cyan"
      },
      {
        "type": "custom",
        "format": "42.40 GiB / 68.45 GiB (\u001b[38;5;3m62%\u001b[0m)",
        "key": "Memory",
        "keyColor": "cyan"
      },
      {
        "type": "custom",
        "format": "0 B / 96.00 GiB (\u001b[38;5;2m0%\u001b[0m)",
        "key": "Swap",
        "keyColor": "cyan"
      },
      {
        "type": "custom",
        "format": "61.76 GiB / 1.65 TiB (\u001b[38;5;2m3%\u001b[0m) - zfs",
        "key": "Disk (/)",
        "keyColor": "cyan"
      },
      {
        "type": "custom",
        "format": "1.36 TiB / 3.17 TiB (\u001b[38;5;2m42%\u001b[0m) - zfs",
        "key": "Disk (/data)",
        "keyColor": "cyan"
      },
      {
        "type": "custom",
        "format": "898.14 GiB / 1.31 TiB (\u001b[38;5;3m67%\u001b[0m) - zfs",
        "key": "Disk (/mtp)",
        "keyColor": "cyan"
      },
      {
        "type": "custom",
        "format": "enp133s0: 10.0.0.5",
        "key": "Local IP",
        "keyColor": "cyan"
      },
      {
        "type": "custom",
        "format": "en_US.UTF-8",
        "key": "Locale",
        "keyColor": "cyan"
      },
      "break",
      "colors"
    ]
            }
  '';
}

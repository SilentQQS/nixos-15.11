{
  pkgs,
  unstablePkgs,
  nixpkgs24,
  ...
}: {
  #  nixpkgs.config.allowUnfree = true;

  home.packages =
    [
      # unstablePkgs.basalt
      # unstablePkgs.rapidraw
      unstablePkgs.satty
      unstablePkgs.grimblast
      unstablePkgs.hyprpicker
      unstablePkgs.kdePackages.kdenlive
      # unstablePkgs.vicinae
      nixpkgs24.nvtopPackages.full
      # nixpkgs24.osu-lazer
    ]
    ++ (with pkgs; [
      # Packages in each category are sorted alphabetically
      # optinix
      # blender
      # cudatoolkit
      # desktop-file-utils
      # doxx
      # hyprnome
      # onlyoffice-desktopeditors
      # pdf4qt
      # coppwr
      # qutebrowser
      gnome-clocks
      # blanket
      # gradia
      # handbrake
      # impala
      # wayfreeze
      # zed-editor-fhs
      # cmatrix
      # cbonsai
      gamescope
      # vkmark
      # onefetch
      # tty-clock
      nurl
      systemctl-tui
      vim
      util-linux
      udisks
      ouch
      trash-cli
      imagemagick
      # tor-browser
      adwsteamgtk
      # davinci-resolve
      chromium
      gimp
      # krita
      # nuclear
      # audacity
      # mission-center
      # ydotool
      wev
      # trilium-next-desktop
      # tribler
      # qpwgraph
      gamemode
      # hyprland-qtutils
      hyprpolkitagent
      # snapper-gui
      pavucontrol
      _7zz
      unrar
      # cinny-desktop
      aria2
      # wireshark
      hyperfine
      uv
      ruff
      black
      lsof
      # bat
      socat
      nixd
      alejandra
      helix
      # blanket
      # ghidra
      # radare2
      # scanmem
      # gdb
      # frida-tools
      # patchelf
      # cava
      # sysstat
      # nodejs_24
      # audacity
      prismlauncher-custom
      # appimage-run
      easyeffects
      # networkmanagerapplet
      steam-run-free
      jq
      # wofi
      # vscodium-fhs
      # swww
      # mpvpaper
      #kdePackages.kdenlive
      # inkscape
      # librecad
      #trash-cli
      cpufetch
      goofcord
      # calcurse
      # nemo-with-extensions
      # godot
      # aseprite
      # bandwhich
      # lazydocker
      # delta
      # difftastic
      tokei
      # clang
      # gdb
      # gnumake
      # cmake
      # libpng
      # zlib
      # clippy
      # rustfmt
      # cargo
      # rustc
      # (python311.withPackages (ps: with ps; [evdev numpy pynput pillow]))
      python311
      # python311Packages.tkinter
      exiftool
      iotop
      # hdparm
      # wev
      mediainfo
      # skim
      blobdrop
      vulkan-tools
      # fping
      # tcpdump
      # nmap
      # masscan
      nix-tree
      libqalculate
      # gnupg
      # pass-wayland
      # mtr
      # swaylock
      dust
      ncdu
      netdata
      qbittorrent
      glances
      steam
      heroic
      # lutris
      mangohud
      procs
      lshw
      glxinfo
      fd
      smartmontools
      # gsmartcontrol
      tldr
      power-profiles-daemon
      fastfetch
      #anki
      #code-cursor
      # imv # image-viever-app
      obsidian
      pulsemixer

      # CLI utils
      bc
      bottom
      brightnessctl
      cliphist
      ffmpeg-full
      ffmpegthumbnailer
      # fzf
      #git-graph
      grim
      slurp
      htop
      # atop
      #hyprpicker
      ntfs3g
      microfetch
      #playerctl
      ripgrep
      #showmethekey
      # silicon # It can render your source code into a beautiful image.
      #udisks
      #ueberzugpp
      unzip
      #w3m
      wget
      wl-clipboard
      wl-clip-persist
      #wtype
      yt-dlp
      zip

      # Coding stuff
      # openjdk23
      # jdk17
      #nodejs
      #python311

      # WM stuff
      #libsForQt5.xwaylandvideobridge
      libnotify

      # Other
      # bemoji
      #nix-prefetch-scripts
    ]);
}

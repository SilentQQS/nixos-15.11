{
  programs.mpv = {
    enable = true;
    config = {
      hwdec = "auto";
      "gpu-context" = "wayland";
    };
  };
}

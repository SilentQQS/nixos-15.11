{
  unstablePkgs,
  lib,
  ...
}: {
  programs.btop = {
    enable = true;
    package = unstablePkgs.btop;
    settings = {
      vim_keys = true;
      color_theme = lib.mkForce "TTY";
      update_ms = 1000;
      proc_sorting = "cpu lazy";
      proc_tree = true;
      log_level = "DEBUG";
    };
  };
}

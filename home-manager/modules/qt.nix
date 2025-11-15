{pkgs, ...}: {
  home.packages = with pkgs; [
    catppuccin-kvantum
  ];

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "kvantum";
  };

  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=catppuccin-frappe-blue
    '';

    "Kvantum/catppuccin-frappe-blue".source = "${pkgs.catppuccin-kvantum}/share/Kvantum/catppuccin-frappe-blue";
  };
}

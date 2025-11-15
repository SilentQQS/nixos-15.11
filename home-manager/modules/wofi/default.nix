{
  programs.wofi = {
    enable = true;
    settings = {
      allow_markup = true;
      allow_images = true;
      width = 550;
      height = 750;
    };
  };

  home.file.".config/wofi/style.css".source = ./style.css;
}

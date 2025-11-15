{lib, ...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        # disable_loading_bar = false;
        grace = 10;
        hide_cursor = false;
        # no_fade_in = false;
      };

      label = {
        text = "$TIME";
        # font_size = 96;
        # font_family = "JetBrains Mono";
        # color = "rgba(235, 219, 178, 1.0)";
        position = "0, 600";
        halign = "center";
        # walign = "center";

        shadow_passes = 1;
      };

      # background = [
      #   {
      #     path = "screenshot";
      #     blur_passes = 3;
      #     blur_size = 8;
      #   }
      # ];

      input-field = [
        {
          monitor = "";
          size = "200, 50";
          position = "0, -80";
          outline_thickness = 5;
          placeholder_text = "Введите пароль";
          dots_center = true;

          # Цвета
          font_color = "rgb(d0d0d0)";
          inner_color = "rgb(151515)";
          fail_color = "rgb(ac4142)";
          check_color = "rgb(f4bf75)";
        }
      ];
    };
  };
}

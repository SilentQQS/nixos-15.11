{
  programs.swayimg = {
    enable = true;

    settings = {
      viewer = {
        window = "#10000010";
        transparency = "grid";
        scale = "fit"; # (optimal/width/height/fit/fill/real/keep)
        position = "center"; # (center/top/bottom/free/...)
        history = 1;
        preload = 1;
      };

      gallery = {
        size = 200;
        cache = 100;
        pstore = "no";
        fill = "yes";
      };

      info = {
        show = "yes";
        "info_timeout" = 5;
        "status_timeout" = 3;
      };

      "info.viewer" = {
        top_left = "+name,+format,+filesize,+imagesize,+exif";
        top_right = "index";
        bottom_left = "scale,frame";
        bottom_right = "status";
      };

      "keys.viewer" = {
        h = "prev_file";
        l = "next_file";
        k = "step_up 10";
        j = "step_down 10";

        g = "mode gallery";
      };

      "keys.gallery" = {
        h = "step_left";
        l = "step_right";
        k = "step_up";
        j = "step_down";

        g = "mode viewer";
      };
    };
  };
}

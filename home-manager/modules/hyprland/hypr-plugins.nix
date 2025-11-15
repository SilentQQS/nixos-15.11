{
  home.file."/.config/hypr/hypr-plugins.conf" = {
    text = ''
       plugin:dynamic-cursors {
        enabled = true
        mode = stretch
        threshold = 2
        # tilt {
        #   limit = 5000
        #   function = negative_quadratic
        #   window = 100
        # }
        rotate {
          length = 20
          offset = 0.0
        }
        hyprcursor {
        nearest = false
        # enabled = true
        # resolution = -1
        # fallback = clientside
        }
        stretch {
          limit = 3000
          function = quadratic
          window = 100
        }
      }
    '';
    # executable = true;
  };
}

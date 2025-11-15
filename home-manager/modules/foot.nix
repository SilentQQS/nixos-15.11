{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.foot = {
    enable = true;
    settings = {
      scrollback = {
        lines = 100000;
      };
      # cursor = {
      #   blink = "no";
      # };
      # bell = {
      # urgent = "yes";
      # notify = "yes";
      # visual = "yes";
      # command-focused = "no";
      # };
      # desktop-notifications = {
      # command = "notify-send --wait --app-name \${app-id} --icon \${app-id} --category \${category} --urgency \${urgency} --expire-time \${expire-time} --hint STRING:image-path:\${icon} --hint BOOLEAN:suppress-sound:\${muted} --hint STRING:sound-name:\${sound-name} --replace-id \${replace-id} \${action-argument} --print-id -- \${title} \${body}";
      # command-action-argument = "--action \${action-name}=\${action-label}";
      # inhibit-when-focused = "yes";
      # };
      main = {
        font = lib.mkForce "BigBlueTermPlus Nerd Font Mono:style=Regular:size=10";
        term = "xterm-256color";
        initial-window-size-chars = "150x50";
      };
    };
  };
}

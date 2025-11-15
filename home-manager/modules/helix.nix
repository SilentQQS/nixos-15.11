{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    nixd
    alejandra
  ];

  programs.helix = {
    enable = true;
    settings = {
      theme = lib.mkForce "catppuccin_mocha";
      editor = {
        cursor-shape = {
          normal = "block";
          insert = "block";
          select = "block";
        };

        line-number = "relative";
        cursorline = true;
        text-width = 100;
        cursorcolumn = false;
        auto-pairs = true;
        auto-completion = true;
        file-picker.hidden = false;
        auto-format = true;
        idle-timeout = 200;
        auto-save = false;
        completion-trigger-len = 1;
        rulers = [100];
        soft-wrap = {
          enable = true;
          wrap-at-text-width = true;
        };
        insert-final-newline = true;

        shell = ["sh" "-c"];

        bufferline = "multiple";
        color-modes = true;
        true-color = true;
        scrolloff = 8;

        statusline = {
          left = [
            "mode"
            "spinner"
            "version-control"
            "read-only-indicator"
            "file-modification-indicator"
          ];
          center = ["file-name"];
          right = [
            "diagnostics"
            "selections"
            "position"
            "position-percentage"
            "file-type"
            "file-encoding"
            "file-line-ending"
            "register"
          ];
        };

        whitespace.render = {
          space = "all";
          tab = "all";
          newline = "none";
        };

        indent-guides.render = true;

        lsp = {
          display-messages = true;
          auto-signature-help = true;
          display-inlay-hints = true;
          display-signature-help-docs = true;
        };
      };
      keys = {
        normal = {
          "C-j" = "page_down";
          "C-k" = "page_up";
        };
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        file-types = ["nix"];
        formatter.command = "${pkgs.alejandra}/bin/alejandra";
        language-servers = ["nixd"];
      }
    ];
  };
}

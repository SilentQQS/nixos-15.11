{pkgs, ...}: {
  programs.bat = {
    enable = true;
    package = pkgs.bat;

    config = {
      pager = "less -FR";
      # paging = "never"; # or always (not a cat)
      # "show-all" = true;
      wrap = "auto";
      map-syntax = [
        "*.py:Python"
        "*.rs:Rust"
        "*.go:Go"
        "*.c:C"
        "*.cpp:C++"
        "*.h:C++"
        "*.lua:Lua"
      ];
    };

    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      batgrep
      batwatch
    ];

    syntaxes = {};
    themes = {};
  };
}

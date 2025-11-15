{
  environment.sessionVariables = rec {
    TERMINAL = "foot";
    EDITOR = "hx";
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "${XDG_BIN_HOME}"
    ];
  };
}

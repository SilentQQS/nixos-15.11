{ pkgs, unstablePkgs, ... }:

{
  fonts.packages = with pkgs; [
   # (nerdfonts.override { fonts = [ "FiraCode" "BigBlueTerminal" ]; })
   nerd-fonts.fira-code
   nerd-fonts.bigblue-terminal
   # unstablePkgs.nerd-fonts.bigblue-terminal
  ];
}


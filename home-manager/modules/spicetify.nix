{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  # OPTION HERE >> "https://gerg-l.github.io/spicetify-nix/extensions.html"

  programs.spicetify = {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      volumePercentage
      hidePodcasts
      shuffle
    ];

    # enabledCustomApps = with spicePkgs.apps; [
    #   marketplace
    #   newReleases
    #   ncsVisualizer
    # ];

    # enabledSnippets = with spicePkgs.snippets; [
    #   rotatingCoverart
    #   pointer
    # ];

    theme = spicePkgs.themes.matte;
    # theme = spicePkgs.themes.catppuccin;
    # colorScheme = "mocha";
    #
  };
}

{
  config,
  pkgs,
  ...
}: {
  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override {
      cudaSupport = true;
    };
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi #optional AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
      #  droidcam-obs
    ];
  };
  # nixpkgs.overlays = [
  #   (self: super: {
  #     obs-studio = super.obs-studio.overrideAttrs (oldAttrs: {
  #       postInstall = ''
  #         ${oldAttrs.postInstall or ""}
  #         substituteInPlace $out/share/applications/com.obsproject.Studio.desktop \
  #           --replace "Exec=obs" "Exec=env LIBVA_DRIVER_NAME=radeonsi obs"
  #       '';
  #     });
  #   })
  # ];
}

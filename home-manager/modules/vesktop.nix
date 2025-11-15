{pkgs, ...}: {
  home.packages = with pkgs; [
    #(vesktop.override { electron = pkgs.electron; })
    (vesktop.overrideAttrs (finalAttrs: previousAttrs: {
      desktopItems = [
        ((builtins.elemAt previousAttrs.desktopItems 0).override {
          exec = "vesktop --disable-features=WebRtcAllowInputVolumeAdjustment --ozone-platform-hint=auto --enable-webrtc-pipewire-capturer --enable-features=WaylandWindowDecorations --enable-features=UseOzonePlatform --ozone-platform=wayland --use-gl=angle --use-angle=gl --enable-features=VaapiVideoDecodeLinuxGL,VaapiVideoEncoder %U";
        })
      ];
    }))
  ];
}

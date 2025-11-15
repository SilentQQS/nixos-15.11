{
  config,
  pkgs,
  lib,
  ...
}: let
  name = "shutter-encoder";
  version = "19.4";

  shutterEncoderAppImage = pkgs.fetchurl {
    url = "https://www.shutterencoder.com/sdc_download/497/?key=lfpx4wqaghm4zgswrp015tljfm75ek";
    sha256 = "1NtWYsqOB3mT1ifFH5F3G4DFNETbZHeF8Xgfrzrxllg=";
    name = "shutter-encoder-${version}.AppImage";
  };
in {
  home.packages = [pkgs.appimage-run];

  xdg.desktopEntries.shutter-encoder = {
    name = "Shutter Encoder";
    genericName = "Video Converter";
    exec = "${pkgs.appimage-run}/bin/appimage-run ${shutterEncoderAppImage}";
    terminal = false;
    categories = ["AudioVideo" "Video"];
    icon = "video-x-generic";
    type = "Application";
  };
}

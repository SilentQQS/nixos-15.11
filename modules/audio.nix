{
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;

    # extraConfig.pipewire-pulse."virtual-mic" = {
    # "context.modules" = [
    # {
    # name = "libpipewire-module-loopback";
    # args = {
    # "node.description" = "VirtualMic";
    # "capture.props" = {
    # "media.class" = "Audio/Source";
    # "node.name" = "VirtualMic";
    # };
    # };
    # }
    # ];
    # };
  };
}

{ config, lib, pkgs, ... }:
{
  boot.initrd.kernelModules = [ "amdgpu" ]; 
 
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.graphics.enable32Bit = true; 
 
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ 
     # mesa
      libva
      vaapiVdpau
      libvdpau-va-gl
      libva-utils
      
    ];
  };

  environment.systemPackages = with pkgs; [
    vulkan-loader
    vulkan-tools
    vdpauinfo
  ];
  
  environment.variables = {
    LIBVA_DRIVER_NAME = "radeonsi";
    WLR_RENDERER_ALLOW_SOFTWARE = "0";
    __GL_VRR_ALLOWED = "1";
    WLR_DRM_NO_MODIFIERS = "1";
  };

  boot.extraModprobeConfig = ''
    blacklist nouveau
    options nouveau modeset=0
  '';
  
  services.udev.extraRules = ''
    # Remove NVIDIA USB xHCI Host Controller devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
    # Remove NVIDIA USB Type-C UCSI devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
    # Remove NVIDIA Audio devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
    # Remove NVIDIA VGA/3D controller devices
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
  '';
  boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
}

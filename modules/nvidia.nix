{
  config,
  # unstablePkgs,
  pkgs,
  ...
}: {
  hardware.nvidia.nvidiaSettings = true;

  hardware.nvidia.open = false;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.dynamicBoost.enable = true;

  boot.initrd.kernelModules = ["amdgpu"];
  boot.kernelModules = ["nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm"];
  services.xserver.videoDrivers = ["nvidia"];
  boot.blacklistedKernelModules = ["nouveau" "nvidiafb"];
  # boot.kernelParams = ["module_blacklist=amdgpu"];

  hardware.nvidia.prime = {
    # offload.enable = true;
    sync.enable = true;
    # offload.enableOffloadCmd = true;

    # Проверьте с помощью `lspci | grep -E "VGA|3D"`
    nvidiaBusId = "PCI:1:0:0";
    amdgpuBusId = "PCI:64:0:0"; # Или PCI ID вашей интегрированной карты
  };
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.graphics.extraPackages = with pkgs; [nvidia-vaapi-driver libGL libpciaccess];
  hardware.nvidia.powerManagement.enable = false;
  hardware.nvidia.powerManagement.finegrained = false;

  boot.extraModprobeConfig = ''
    # options nvidia NVreg_DynamicPowerManagement=0x00
  '';

  # Используем кастомный драйвер NVIDIA
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;

  environment.systemPackages = with pkgs; [
    vdpauinfo
    libva
    libva-utils
    vulkan-loader
    vulkan-tools
  ];

  environment.variables = {
    __GL_VRR_ALLOWED = 1;
    # __GLX_VENDOR_LIBRARY_NAME= "nvidia";
    #  WLR_NO_HARDWARE_CURSORS = "1";
    # WLR_RENDERER_ALLOW_SOFTWARE = "0"; # ON GPU ACEL
    WLR_DRM_NO_MODIFIERS = 1;
  };
}

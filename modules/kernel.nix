{pkgs, ...}: {
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernel.sysctl."kernel.sysrq" = 1;
  # boot.kernelParams = [
  #   "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  # ];
}

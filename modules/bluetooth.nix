{pkgs, ...}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        ControllerMode = "bredr"; # Fix frequent Bluetooth audio dropouts
        Enable = "Source,Sink,Media,Socket"; # For modern headsets using the A2DP profile
        Experimental = true; # for battery charge
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };
  environment.systemPackages = with pkgs; [
    bluetui
  ];
  # services.blueman.enable = true;
}

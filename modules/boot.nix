{lib, ...}: {
  boot = {
    kernelModules = ["uinput" "zram"];
    # extraModprobeConfig = ''
    #   options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    # '';
    initrd.systemd.enable = true;
    loader = {
      # efi.canTouchEfiVariables = false;
      timeout = lib.mkForce 0; # press any key during boot to get in
      systemd-boot = {
        enable = true;
        memtest86.enable = true;
        configurationLimit = 20;
        consoleMode = "max";
      };
    };
    tmp.useTmpfs = true;
    tmp.tmpfsSize = "30%";
  };
}

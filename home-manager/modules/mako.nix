{ config, pkgs, lib, ... }:

{
  services.mako = {
    enable = true;
    package = pkgs.mako;
    settings = {
      sort = "-time";
      layer = "overlay";
      background-color = lib.mkForce "#1e222a7f";
      width = 450; 
      height = 150; 
      border-size = 1;
      border-radius = 10; 
      icons = 0;
      max-icon-size = 64;
      padding = 12; 
      margin = 12; 
      anchor = "top-center"; 
      default-timeout = 5000;  
      group-by = lib.mkForce "urgency";
      
      "urgency=low" = {
        border-color= "#cccccc"; 
      };
      "urgency=normal" = {
        border-color= "#99c0d0";
      };
      "urgency=critical" = {
        border-color= "#bf616a";
        default-timeout= 0;
      }; 
    };
  };
}


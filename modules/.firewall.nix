{
  networking.nftables.enable = true;

  networking.firewall = {
    enable = true;                        
    allowPing = false;                    # ICMP (ping)
    logRefusedConnections = false;         

    allowedTCPPorts = [ ];                # SSH and HTTPS | 22 and 443
    allowedUDPPorts = [ ];                # UDP
  };
    
  networking.nftables.ruleset = ''
    table inet my_firewall {
      chain input {
        type filter hook input priority 0; policy drop;
        iifname "lo" accept
        ct state established,related accept
      }
    }
  '';
}


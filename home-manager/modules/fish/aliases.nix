{
  l = "eza --icons --all --tree --level=1";
  d = "eza --icons --all --only-dirs";
  ll = "eza --icons --all --long --git";
  llt = "eza --icons --all --long --git --total-size";
  lt = "eza --all --tree";
  lt2 = "eza --all --long --tree --level=2";
  lt3 = "eza --all --long --tree --level=3";
  lt4 = "eza --all --long --tree --level=4";

  ct = "bat --paging=never";
  bcat = "bat --paging=never -A";
  bgrep = "batgrep";
  bdiff = "batdiff";
  bwatch = "batwatch";
  bman = "batman";

  lan-scan = "fping -a -q -r 0 -t 50 -i 1 -g 192.168.32.0/24";
  warpon = "doas wg-quick up ~/.config/wgcf/wgcf-profile.conf";
  warpoff = "doas wg-quick down ~/.config/wgcf/wgcf-profile.conf";
  prime-run = "DRI_PRIME=1";
}

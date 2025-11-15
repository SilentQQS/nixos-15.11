{
  services.earlyoom = {
    enable = true;
    freeMemThreshold = 10; # % свободной RAM для срабатывания
    freeSwapThreshold = 10; # % свободного swap
    # prefer = ["^firefox$"];  # кого убивать первым
    # avoid = ["^mpv$" "^steam$"];  # кого стараться не трогать
  };
}

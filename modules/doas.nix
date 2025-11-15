{
  security.doas.enable = true;
  #security.sudo.enable = true;
  security.doas.extraRules = [
    {
      users = ["fotom"];
      keepEnv = true;
      persist = true;
    }
  ];
}

{
  services.snapper.configs = {
    root = {
      SUBVOLUME = "/"; # корень системы
      TIMELINE_CREATE = true;
      TIMELINE_CLEANUP = true;
      NUMBER_CLEANUP = 10; # хранить 10 последних
      NUMBER_LIMIT = 7; # для timeline
      ALGORITHM_CLEANUP = "number";
      INTERVAL = "daily"; # ежедневные снапшоты
    };

    home = {
      SUBVOLUME = "/home"; # полный путь к домашнему каталогу
      TIMELINE_CREATE = false;
      TIMELINE_CLEANUP = true;
      NUMBER_CLEANUP = 10;
      ALGORITHM_CLEANUP = "number";
    };
  };
}

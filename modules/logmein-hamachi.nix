{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    logmein-hamachi
  ];

  systemd.services.hamachi = {
    description = "LogMeIn Hamachi VPN service";
    wantedBy = ["multi-user.target"];
    after = ["network.target"];
    serviceConfig = {
      # Указываем путь к демону + явно каталог конфигурации
      ExecStart = "${pkgs.logmein-hamachi}/bin/hamachid -c /var/lib/logmein-hamachi";

      # Чтобы systemd не ограничивал доступ к каталогу
      ReadWritePaths = ["/var/lib/logmein-hamachi"];

      # Повторный запуск при выходе (hamachid сам может завершаться при простое)
      Restart = "always";
      RestartSec = "5s";

      # Безопасные флаги systemd
      Type = "forking";
    };
  };
}

{
  networking.firewall.enable = false;
  networking.nftables.enable = true;

  networking.nftables.ruleset = ''
    table inet my_firewall {
      set temp_ports {
        type inet_proto . inet_service
        flags interval
        comment "Temporarily opened ports"
      }

      chain rpfilter {
        type filter hook prerouting priority mangle + 10; policy drop;
        meta nfproto ipv4 udp sport . udp dport { 68 . 67, 67 . 68 } accept comment "Allow DHCPv4"
        fib saddr . mark . iif oif exists accept
        jump rpfilter_allow
      }

      chain rpfilter_allow {
        # Можно расширить при необходимости
      }

      chain input {
        type filter hook input priority filter; policy drop;

        # Доверенные интерфейсы
        iifname "lo" accept comment "Loopback interface"

        # Защита от мусора и сессий без контекста
        ct state invalid drop
        ct state established,related accept

        # Новые и untracked — к ручной проверке
        ct state new jump input_allow
        ct state untracked jump input_allow
      }

      chain input_allow {
        # Разрешённые временные порты — редактируй через runtime
        meta l4proto . th dport @temp_ports accept comment "Allow temporary opened ports"

        # ICMPv6 — только безопасные типы
        icmpv6 type != { nd-redirect, 139 } accept comment "Safe ICMPv6"

        # DHCPv6
        ip6 daddr fe80::/64 udp dport 546 accept comment "Allow DHCPv6 client"

        #Allow DNS
        ip daddr { 1.1.1.1, 1.0.0.1 } udp dport 53 accept comment "Allow DNS to Cloudflare"
        ip6 daddr { 2606:4700:4700::1111, 2606:4700:4700::1001 } udp dport 53 accept comment "Allow IPv6 DNS to Cloudflare"


      }
    }
  '';
}

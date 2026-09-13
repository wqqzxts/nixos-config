{
  networking = {
    nameservers = [
      "127.0.0.1"
      "192.168.1.1"
      "192.168.0.1"
    ];
    networkmanager = {
        enable = true;
        dns = "default";
    };

    firewall = {
      allowPing = false;
      extraCommands = ''
        ip6tables -I nixos-fw -p icmpv6 --icmpv6-type echo-request -j DROP
      '';
      extraStopCommands = ''
        ip6tables -D nixos-fw -p icmpv6 --icmpv6-type echo-request -j DROP 2>/dev/null || true
      '';
    };
  };

  boot.kernelModules = [ "tcp_bbr" ];

  boot.kernel.sysctl = {
    "net.ipv4.icmp_echo_ignore_all" = 1;
    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv4.conf.default.send_redirects" = 0;
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.default.accept_redirects" = 0;
    "net.ipv4.conf.all.accept_source_route" = 0;
    "net.ipv4.conf.default.accept_source_route" = 0;
    "net.ipv6.conf.all.accept_source_route" = 0;
    "net.ipv4.icmp_echo_ignore_broadcasts" = 1;
    "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
    "net.ipv4.tcp_syncookies" = 1;

    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "cake";
    "net.ipv4.tcp_fastopen" = 1;
    "net.ipv4.tcp_mtu_probing" = 1;
    "net.core.rmem_max" = 16777216;
    "net.core.wmem_max" = 16777216;
    "net.ipv4.tcp_rmem" = "4096 131072 16777216";
    "net.ipv4.tcp_wmem" = "4096 87380 16777216";
    "net.ipv4.tcp_slow_start_after_idle" = 0;
  };

  services.dnscrypt-proxy = {
    enable = true;
    settings = {
      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };

      listen_addresses = ["127.0.0.1:53"];
      ipv6_servers = false;
      block_ipv6 = true;
      dnscrypt_servers = true;
      doh_servers = true;
      odoh_servers = false;
      require_dnssec = false;

      require_nolog = true;
      require_nofilter = true;

#     force_tcp = true;
      http3 = false;
      http3_probe = false;

#     ignore_system_dns = true;

      server_names = [ "google" ];
    };
  };
}

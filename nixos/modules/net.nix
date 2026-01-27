{
  networking = {
    nameservers = [
      "127.0.0.1"
    ];
    networkmanager = {
        enable = true;
        dns = "none";
    };
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

      force_tcp = true;
      http3 = false;
      http3_probe = false;

      ignore_system_dns = true;
      fallback_resolvers = [ "1.1.1.1:53" ];

      server_names = [ "google" ];
    };
  };
}

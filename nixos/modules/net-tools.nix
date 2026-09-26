{ pkgs, ... }: {
  programs = {
    mtr.enable = true;
    trippy.enable = true;
    bandwhich.enable = true;
    iftop.enable = true;
  };

  environment.systemPackages = with pkgs; [
    arp-scan
    bmon
    conntrack-tools
    doggo
    ethtool
    gping
    hping
    inetutils
    iperf3
    ipcalc
    iw
    ldns
    lsof
    mitmproxy
    net-tools
    nethogs
    nftables
    ngrep
    nmap
    speedtest-cli
    sslscan
    tcptraceroute
    testssl
    traceroute
    wavemon
    websocat
    wireguard-tools
    xh
  ];
}

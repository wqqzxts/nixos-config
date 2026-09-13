{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # chromium
    imv
    mpv
    nautilus
    pavucontrol
    qbittorrent

    bemoji
    brightnessctl
    cliphist
    hyprpicker
    libnotify
    wl-clipboard
    wtype
    xwayland-satellite

    ffmpeg
    ffmpegthumbnailer
    mediainfo
    playerctl
    yt-dlp

    ntfs3g
    p7zip
    udisks

    bc
    bottom
    cifs-utils
    claude-code
    dig
    fzf
    htop
    inotify-tools
    jq
    openssl
    pamixer
    power-profiles-daemon
    pulseaudio
    ripgrep
    samba
    tcpdump
    ueberzugpp
    unixtools.netstat
    unrar
    w3m
    wf-recorder
    wget
    whois
  ];
}

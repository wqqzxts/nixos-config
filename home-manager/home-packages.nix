{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # apps
    chromium
    imv
    mpv
    nautilus
    pavucontrol
    qbittorrent
    vscodium

    # wayland
    bemoji
    brightnessctl
    cliphist
    hyprpicker
    libnotify
    wl-clipboard
    wtype
    xdg-desktop-portal-gtk
    xwayland-satellite

    # multimedia
    ffmpeg
    ffmpegthumbnailer
    mediainfo
    playerctl
    yt-dlp

    # file management
    ntfs3g
    p7zip
    udisks

    # cli utilities
    bc
    bottom
    dig
    fzf
    htop
    inotify-tools
    jq
    pamixer
    power-profiles-daemon
    pulseaudio
    ripgrep
    tcpdump
    unixtools.netstat
    w3m
    wf-recorder
    wget
    whois

    # entertainment
    asciiquarium
    cava
    cbonsai
    era
    nitch
    pipes-rs
    unimatrix
  ];
}

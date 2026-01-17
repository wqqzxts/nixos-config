{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # apps
    imv
    mpv
    pavucontrol
    qbittorrent
    vscodium

    # wayland
    bemoji
    brightnessctl
    cliphist
    grimblast
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
    fzf
    htop
    inotify-tools
    jq
    pamixer
    power-profiles-daemon
    pulseaudio
    ripgrep
    ueberzugpp
    w3m
    wf-recorder
    wget

    # entertainment
    asciiquarium
    cava
    cbonsai
    era
    fastfetch
    nitch
    pipes-rs
    unimatrix
  ];
}

{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # apps
    imv
    mpv
    pavucontrol
    qbittorrent

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
    cava
    fzf
    htop
    ripgrep
    ueberzugpp
    w3m
    wget

    # entertainment
    asciiquarium
    cbonsai
    era
    fastfetch
    nitch
    unimatrix
  ];
}

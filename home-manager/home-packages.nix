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
    wl-clipboard
    wtype

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
    w3m
    wget

    # wm stuff
    libnotify
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland

    # entertainment
    cmatrix
    fastfetch
    hollywood
    lolcat
    nitch
    ufetch
    unimatrix
  ];
}

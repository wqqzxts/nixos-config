{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # apps
    imv
    mpv
    pavucontrol
    qbittorrent
    chromium

    # wayland
    brightnessctl
    cliphist
    # eww
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
    fzf
    htop
    ripgrep
    ueberzugpp
    w3m
    wget

    # wm stuff
    libnotify
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland

    # entertainment
    bemoji
    cava
    fastfetch
    nitch
    ufetch
  ];
}

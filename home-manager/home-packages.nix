{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # apps
    firefox
    imv
    mpv
    pavucontrol
    qbittorrent

    # wayland
    brightnessctl
    cliphist
    grimblast
    hyprpicker
    showmethekey
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
    silicon
    ueberzugpp
    w3m
    wget

    # development
    clang
    git-graph
    jdk21
    nix-prefetch-scripts
    nodejs_24
    poetry
    python313

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

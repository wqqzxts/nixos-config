{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Packages in each category are sorted alphabetically

    # Desktop apps
    anki
    firefox
    imv
    libreoffice-qt-fresh
    mpv
    obs-studio
    obsidian
    pavucontrol
    telegram-desktop
    qbittorrent

    # CLI utils
    bc
    bottom
    brightnessctl
    cliphist
    fastfetch
    ffmpeg
    ffmpegthumbnailer
    fzf
    git-graph
    grimblast
    htop
    hyprpicker
    nitch
    ntfs3g
    mediainfo
    playerctl
    p7zip
    ripgrep
    showmethekey
    silicon
    udisks
    ueberzugpp
    w3m
    wget
    wl-clipboard
    wtype
    yt-dlp

    # Coding stuff

    # WM stuff
    libnotify
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland

    # Other
    bemoji
    nix-prefetch-scripts
  ];
}

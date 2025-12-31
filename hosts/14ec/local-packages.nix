{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    # apps
    anki
    libreoffice-qt-fresh
    obs-studio
    obsidian
    telegram-desktop
    libpng

    # development
    clang
    docker
    git-graph
    jdk21
    nix-prefetch-scripts
    nodejs_24
    poetry
    python313

    # regreet
    gruvbox-material-gtk-theme
  ];
}

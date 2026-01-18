{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    # apps
    anki
    gimp
    libreoffice-qt-fresh
    obs-studio
    obsidian
    spotify
    telegram-desktop
    vesktop
    wineWowPackages.waylandFull
    winetricks

    # development
    clang
    docker
    git-graph
    nix-prefetch-scripts
  ];
}

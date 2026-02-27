{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;

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
    spice
    spice-vdagent

    # development
    docker
    git-graph
    nix-prefetch-scripts
  ];
}

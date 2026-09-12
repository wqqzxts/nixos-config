{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    # apps
    anki
    adwaita-icon-theme
    gamemode
    lutris
    mangohud
    obs-studio
    obsidian
    spice
    spice-vdagent
    spotify
    telegram-desktop
    winetricks
    steam-run

    # development
    docker
    git-graph
    nix-prefetch-scripts
  ];
}

{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings.ip = "127.0.0.1";

  environment.systemPackages = with pkgs; [
    anki
    adwaita-icon-theme
    gamemode
    lutris
    mangohud
    obs-studio
    spice
    spice-vdagent
    spotify
    telegram-desktop
    winetricks

    docker
    git-graph
    nix-prefetch-scripts

    asciiquarium
    cava
    cbonsai
    era
    nitch
    pipes-rs
    unimatrix
  ];
}

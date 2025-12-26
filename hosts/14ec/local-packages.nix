{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # apps
    anki
    libreoffice-qt-fresh
    obs-studio
    obsidian
    telegram-desktop
  ];
}

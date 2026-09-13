{ pkgs, ... }: {
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  security.pam.services.hyprlock = {};
}

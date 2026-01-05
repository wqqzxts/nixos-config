{
  programs.hyprland = {
    enable = true;
    withUWSM = false;
    xwayland.enable = false;
  };

  security.pam.services.hyprlock = {};
}

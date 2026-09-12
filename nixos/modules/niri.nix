{ pkgs, ... }: {
  # nixpkgs' native niri module: pulls in hardware.graphics, polkit, portals
  # (gnome + gtk), gnome-keyring, fonts, xdg and the niri systemd units.
  programs.niri = {
    enable = true;
    # same overlay package as home-manager, so only one niri build exists
    package = pkgs.niri-unstable;
  };

  # hyprlock authenticates through PAM; without this it falls back to /etc/pam.d/other
  security.pam.services.hyprlock = {};
}

{ inputs, pkgs, ... }:
let
  hyprPkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    package = hyprPkgs.hyprland;
    portalPackage = hyprPkgs.xdg-desktop-portal-hyprland;
    settings = {
      "$terminal" = "alacritty";
      "$fileManager" = "$terminal -e sh -c 'yazi'";
      "$menu" = "rofi -show drun";
    };
  };
}

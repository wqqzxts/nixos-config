{ config, ...}: {
  programs.niri.settings = {
    prefer-no-csd = true;
    hotkey-overlay.skip-at-startup = true;
    screenshot-path = "~/pictures/screenshots/screenshot from %Y-%m-%d %H-%M-%S.png";

    workspaces = {
      "1" = {};
      "2" = {};
    };

    environment = {
      "NIXOS_OZONE_WL" = "1";
      "XDG_CURRENT_DESKTOP" = "niri";
      "XDG_SESSION_DESKTOP" = "niri";
      "XDG_SESSION_TYPE" = "wayland";
      "QT_QPA_PLATFORM" = "wayland";
    };

    spawn-at-startup = [
      { command = [ "eww" "daemon" ]; }
      { command = [ "ewwbar" ]; }
      { command = [ "wl-paste" "--type" "image" "--watch" "cliphist" "store" ]; }
      { command = [ "wl-paste" "--type" "text" "--watch" "cliphist" "store" ]; }
    ];

    cursor = {
      hide-when-typing = true;
      theme = config.stylix.cursor.name;
      size = config.stylix.cursor.size;
    };
  };
}

{
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
      { command = [ "hyprlock" ]; }
      { command = [ "waybar" ]; }
      { command = [ "eww" "daemon" ]; }
      { command = [ "wl-paste" "--type" "image" "--watch" "cliphist" "store" ]; }
      { command = [ "wl-paste" "--type" "text" "--watch" "cliphist" "store" ]; }
    ];
  };
}

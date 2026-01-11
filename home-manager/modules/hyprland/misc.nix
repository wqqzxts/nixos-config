{
  wayland.windowManager.hyprland.settings = {
    env = [
      # hint electron apps to use wayland
      "NIXOS_OZONE_WL,1"
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_TYPE,wayland"
      "XDG_SESSION_DESKTOP,Hyprland"
      "QT_QPA_PLATFORM,wayland"
      "XDG_SCREENSHOTS_DIR,$HOME/screens"
    ];

    exec-once = [
      "hyprlock"
      "loginctl lock-session"
      "eww daemon"
      "waybar"
      "wl-paste --type image --watch cliphist store"
      "wl-paste --type text --watch cliphist store"
    ];

    misc = {
      force_default_wallpaper = 0;
      disable_hyprland_logo = true;
      animate_manual_resizes = false;
    };
  };
}

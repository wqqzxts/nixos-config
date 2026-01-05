{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      env = [
        # hint electron apps to use wayland
        "NIXOS_OZONE_WL,1"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_QPA_PLATFORM,wayland"
        "XDG_SCREENSHOTS_DIR,$HOME/screens"
      ];

      monitor = ",1920x1080@60,auto,1.0";
      "$mainMod" = "SUPER";
      "$terminal" = "alacritty";
      "$fileManager" = "$terminal -e sh -c 'ranger'";
      "$menu" = "wofi";

      exec-once = [
        "waybar"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      general = {
        gaps_in = 5;
        "gaps_out" = "5,10,5,10";

        border_size = 5;

        "col.active_border" = "rgba(d65d0eff) rgba(98971aff) 45deg";
        "col.inactive_border" = "rgba(3c3836ff)";

        resize_on_border = true;

        allow_tearing = false;
        layout = "master";
      };

      decoration = {
        rounding = 0;

        active_opacity = 0.85;
        inactive_opacity = 0.85;

        shadow = {
          enabled = false;
        };

        blur = {
          enabled = true;
          size = 16;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "expressiveFastSpatial, 0.42, 1.67, 0.21, 0.90"
          "expressiveSlowSpatial, 0.39, 1.29, 0.35, 0.98"
          "expressiveDefaultSpatial, 0.38, 1.21, 0.22, 1.00"
          "emphasizedDecel, 0.05, 0.7, 0.1, 1"
          "emphasizedAccel, 0.3, 0, 0.8, 0.15"
          "standardDecel, 0, 0, 0, 1"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.52, 0.03, 0.72, 0.08"
          "stall, 1, -0.1, 0.7, 0.85"
        ];

        animation = [
          "windowsIn, 1, 3, emphasizedDecel, popin 80%"
          "fadeIn, 1, 3, emphasizedDecel"
          "windowsOut, 1, 2, emphasizedDecel, popin 90%"
          "fadeOut, 1, 2, emphasizedDecel"
          "windowsMove, 1, 3, emphasizedDecel, slide"
          "border, 1, 10, emphasizedDecel"
          "layersIn, 1, 2.7, emphasizedDecel, popin 93%"
          "layersOut, 1, 2.4, menu_accel, popin 94%"
          "fadeLayersIn, 1, 0.5, menu_decel"
          "fadeLayersOut, 1, 2.7, stall"
          "workspaces, 1, 7, menu_decel, slide"
          "specialWorkspaceIn, 1, 2.8, emphasizedDecel, slidevert"
          "specialWorkspaceOut, 1, 1.2, emphasizedAccel, slidevert"
        ];
      };

      input = {
        kb_layout = "us,ru";
        kb_options = "grp:caps_toggle";

      	natural_scroll = false;
      };

      gestures = {
        gesture = [
          "3, horizontal, workspace"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "slave";
        new_on_top = true;
        mfact = 0.5;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };
    };
  };
}

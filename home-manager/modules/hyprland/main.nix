{ inputs, pkgs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprscrolling
    ];
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
      "$fileManager" = "$terminal -e sh -c 'yazi'";
      "$menu" = "rofi -show drun";

      exec-once = [
        "hyprlock"
        "loginctl lock-session"
        "eww daemon"
        "waybar"
        "wl-paste --type image --watch cliphist store"
        "wl-paste --type text --watch cliphist store"
      ];

      general = {
        gaps_in = 5;
        "gaps_out" = "5,7,5,7";

        border_size = 5;

        "col.active_border" = "rgba(bdaa89ff)";
        "col.inactive_border" = "rgba(1d2021ff)";

        resize_on_border = true;

        allow_tearing = true;
        layout = "scrolling";
      };

      decoration = {
        rounding = 0;
        rounding_power = 1;

        active_opacity = 0.85;
        inactive_opacity = 0.85;

        blur = {
          enabled = true;
          size = 24;
          noise = 0.0;
        };

        shadow = {
          enabled = false;
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

        repeat_rate = 40;
        repeat_delay = 225;

        accel_profile = "flat";
        sensitivity = 2.25;

        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.50;
        };
      };

      gestures = {
        workspace_swipe_distance = 500;
        workspace_swipe_cancel_ratio = 0.3;
        gesture = [
          "4, horizontal, workspace"

          "3, right,  dispatcher, layoutmsg, focus l"
          "3, left,   dispatcher, layoutmsg, focus r"

          "3, pinchin,  dispatcher, layoutmsg, fit active"
          "3, pinchout, dispatcher, layoutmsg, colresize 0.5"
        ];
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        animate_manual_resizes = false;
      };

      windowrule = [
        # float
        "match:title ^(Choose wallpaper)(.*)$, center on"
        "match:title ^(Choose wallpaper)(.*)$, float on"
        "match:title ^(Choose wallpaper)(.*)$, size (monitor_w*.60) (monitor_h*.65)"
        "match:title ^(Open File)(.*)$, center on"
        "match:title ^(Open File)(.*)$, float on"
        "match:title ^(Open File)(.*)$, size (monitor_w*.45) (monitor_h*.45)"
        "match:title ^(Select a File)(.*)$, center on"
        "match:title ^(Select a File)(.*)$, float on"
        "match:title ^(Select a File)(.*)$, size (monitor_w*.45) (monitor_h*.45)"
        "match:title ^(Open Folder)(.*)$, center on"
        "match:title ^(Open Folder)(.*)$, float on"
        "match:title ^(Open Folder)(.*)$, size (monitor_w*.45) (monitor_h*.45)"
        "match:title ^(Save As)(.*)$, center on"
        "match:title ^(Save As)(.*)$, float on"
        "match:title ^(Save As)(.*)$, size (monitor_w*.45) (monitor_h*.45)"
        "match:title ^(Library)(.*)$, center on"
        "match:title ^(Library)(.*)$, float on"
        "match:title ^(Library)(.*)$, size (monitor_w*.45) (monitor_h*.45)"
        "match:title ^(File Upload)(.*)$, center on"
        "match:title ^(File Upload)(.*)$, float on"
        "match:title ^(File Upload)(.*)$, size (monitor_w*.45) (monitor_h*.45)"
        "match:title ^(.*)(wants to save)$, center on"
        "match:title ^(.*)(wants to save)$, float on"
        "match:title ^(.*)(wants to save)$, size (monitor_w*.45) (monitor_h*.45)"
        "match:title ^(.*)(wants to open)$, center on"
        "match:title ^(.*)(wants to open)$, float on"
        "match:title ^(.*)(wants to open)$, size (monitor_w*.45) (monitor_h*.45)"

        "match:class ^(org.pulseaudio.pavucontrol)$, center on"
        "match:class ^(org.pulseaudio.pavucontrol)$, float on"
        "match:class ^(org.pulseaudio.pavucontrol)$, size (monitor_w*.45) (monitor_h*.45)"
        "match:class ^(Throne)$, center on"
        "match:class ^(Throne)$, float on"
        "match:class ^(Throne)$, size (monitor_w*.45) (monitor_h*.45)"
        "match:class ^(.blueman-manager-wrapped)$, center on"
        "match:class ^(.blueman-manager-wrapped)$, float on"
        "match:class ^(.blueman-manager-wrapped)$, size (monitor_w*.45) (monitor_h*.45)"
        "match:class ^(ueberzugpp)(.*)$, float on"
        "match:class ^(ueberzugpp)(.*)$, no_anim 1"
        "match:class ^(ueberzugpp)(.*)$, no_focus 1"
        "match:class ^(ueberzugpp)(.*)$, border_size 0"
        # picture in picture
        "match:title ^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$, float on"
        "match:title ^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$, keep_aspect_ratio on"
        "match:title ^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$, move (monitor_w*.73) (monitor_h*.72)"
        "match:title ^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$, size (monitor_w*.25) (monitor_h*.25)"
        "match:title ^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$, float on"
        "match:title ^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$, pin on"
        # tearing
        "match:title .*\.exe, immediate on"
        "match:title .*minecraft.*, immediate on"
        "match:class ^(steam_app).*, immediate on"
      ];
      plugin = {
        hyprscrolling = {
          fullscreen_on_one_column = true;
          column_width = 0.5;
          explicit_column_widths = "0.333,0.5,0.667,1.0";
          focus_fit_method = 1;
          follow_focus = true;
          follow_debounce_ms = 100;
        };
      };
    };
  };
}

{
  wayland.windowManager.hyprland.settings = {
    animations = {
      enabled = true;

      bezier = [
        "fluentDecel, 0, 0.2, 0.4, 1"
        "easeOutCirc, 0, 0.55, 0.45, 1"
        "softSpring, 0.05, 0.9, 0.1, 1.1"
      ];

      animation = [
        "windows, 1, 5, fluentDecel, slide"
        "windowsIn, 1, 5, softSpring, popin 80%"
        "windowsOut, 1, 5, fluentDecel, popin 80%"

        "workspaces, 1, 6, easeOutCirc, slidevert"

        "specialWorkspace, 1, 5, easeOutCirc, slidevert"

        "fadeIn, 1, 4.5, fluentDecel"
        "fadeOut, 1, 4.5, fluentDecel"
        "fadeLayersIn, 1, 4.5, fluentDecel"
        "fadeLayersOut, 1, 4.5, fluentDecel"

        "border, 1, 7, fluentDecel"
        "borderangle, 1, 5, fluentDecel"
      ];
    };
  };
}

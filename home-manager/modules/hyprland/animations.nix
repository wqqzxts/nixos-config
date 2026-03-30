{
  wayland.windowManager.hyprland.settings = {
    animations = {
      enabled = true;

      bezier = [
        # easing like:
        "easeInOut,0.85,0.00,0.10,1.00"
        "easeIn,0.08,0.85,0.18,1.00"

        # spring like (bad looking with gestures):
        "spring,0.65,0.20,0.05,1.25"
        "anticipation,0.25,-0.5,0.05,1.0"
      ];

      animation = [
        # navigation
        "workspaces,1,4,easeIn,slidevert"
        "specialWorkspace,1,4,spring, slidevert"

        # window management
        "windows,1,4,spring,popin"
        "windowsIn,1,4,spring, popin"
        "windowsOut,1,4,easeInOut, popin 35%"
        "fadeLayersIn,1,4,easeIn"
        "fadeLayersOut,1,4,easeIn"

        "border,1,4,easeIn"
      ];
    };
  };
}

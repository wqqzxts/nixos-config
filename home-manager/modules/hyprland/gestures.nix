{
  wayland.windowManager.hyprland.settings = {
    gestures = {
      workspace_swipe_distance = 500;
      workspace_swipe_cancel_ratio = 0.25;
      gesture = [
        "3, vertical, workspace"

        "3, right,  dispatcher, layoutmsg, focus l"
        "3, left,   dispatcher, layoutmsg, focus r"

        "3, pinchin,  dispatcher, layoutmsg, fit active"
        "3, pinchout, dispatcher, layoutmsg, colresize 0.5"
      ];
    };
  };
}

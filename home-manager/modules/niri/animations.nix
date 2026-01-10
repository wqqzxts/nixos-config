{
  programs.niri.settings = {
    animations = {
      enable = true;
      slowdown = 1.0;
      workspace-switch.kind.easing = {
        curve = "cubic-bezier";
        curve-args = [ 0 0.55 0.45 1 ];
        duration-ms = 600;
      };

      horizontal-view-movement.kind.easing = {
        curve = "cubic-bezier";
        curve-args = [ 0 0.55 0.45 1 ];
        duration-ms = 600;
      };

      window-open.kind.spring = {
        stiffness = 500;
        damping-ratio = 0.9;
        epsilon = 0.001;
      };

      window-close.kind.easing = {
        curve = "cubic-bezier";
        curve-args = [ 0 0.2 0.4 1 ];
        duration-ms = 500;
      };

      window-movement.kind.easing = {
        curve = "cubic-bezier";
        curve-args = [ 0 0.2 0.4 1 ];
        duration-ms = 500;
      };

      window-resize.kind.easing = {
        curve = "cubic-bezier";
        curve-args = [ 0 0.2 0.4 1 ];
        duration-ms = 500;
      };

      screenshot-ui-open.kind.easing = {
        curve = "cubic-bezier";
        curve-args = [ 0 0.2 0.4 1 ];
        duration-ms = 450;
      };

      config-notification-open-close.kind.easing = {
        curve = "cubic-bezier";
        curve-args = [ 0 0.2 0.4 1 ];
        duration-ms = 450;
      };
    };
  };
}

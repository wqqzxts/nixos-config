let
  # curves (works bad with gestures)
  easeInOut = [ 0.85 0 0.1 1 ]; # starts very slowly and then incredibly accelerates
  anticipation = [ 0.25 (-0.5) 0.05 1.0 ]; # accumulates at first and then realeases

  # dampings
  jumpy = 0.75; # eye candy
  tight = 0.85; # responsive feel

  # stiffnesses
  hiStiff = 750; # responsive feel
  loStiff = 200; # eye candy

  # epsilon
  e = 0.00001; # that value works nice, but you can try out to lower (but values above 0.005 works baad)
in
{
  programs.niri.settings = {
    animations = {
      enable = true;
      slowdown = 1.0;

      # navigation
      ## workspaces
      workspace-switch.kind.spring = {
        stiffness = loStiff;
        damping-ratio = jumpy;
        epsilon = e;
      };
      ## windows
      horizontal-view-movement.kind.spring = {
        stiffness = loStiff;
        damping-ratio = jumpy;
        epsilon = e;
      };
      ## overview
      overview-open-close.kind.spring = {
        stiffness = loStiff;
        damping-ratio = jumpy;
        epsilon = e;
      };
      ## recent overview - currently doesn't exist in niri nix
      # recent-windows-close.kind.spring = {
      #   stiffness = loStiff;
      #   damping-ratio = jumpy;
      #   epsilon = e;
      # };

      # window management
      ## control
      window-open.kind.spring = {
        stiffness = loStiff;
        damping-ratio = jumpy;
        epsilon = e;
      };
      window-close.kind.easing = {
        curve = "cubic-bezier";
        curve-args = easeInOut;
        duration-ms = 750;
      };
      ## window moving
      window-movement.kind.spring = {
        stiffness = loStiff;
        damping-ratio = jumpy;
        epsilon = e;
      };
      ## window resize
      window-resize.kind.easing = {
        curve = "cubic-bezier";
        curve-args = easeInOut;
        duration-ms = 750;
      };

      # utils
      screenshot-ui-open.kind.easing = {
        curve = "cubic-bezier";
        curve-args = easeInOut;
        duration-ms = 750;
      };

      config-notification-open-close.kind.spring = {
        stiffness = loStiff;
        damping-ratio = jumpy;
        epsilon = e;
      };
      exit-confirmation-open-close.kind.spring = {
        stiffness = loStiff;
        damping-ratio = jumpy;
        epsilon = e;
      };
    };
  };
}

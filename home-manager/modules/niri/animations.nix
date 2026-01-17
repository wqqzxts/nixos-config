let
  # curves (works bad with gestures)
  # easing like:
  easeInOut = [ 0.85 0.00 0.10 1.00 ]; # starts very slowly and then incredibly accelerates
  # spring like:
  anticipation = [ 0.25 (-0.50) 0.05 1.00 ]; # accumulates at first and then realeases

  # animation durations
  candy = 650;
  responsive = 400;

  # dampings
  jumpy = 0.65; # eye candy
  tight = 0.85; # responsive feel

  # stiffnesses
  loStiff = 150; # eye candy
  hiStiff = 750; # responsive feel

  # epsilon
  e = 0.00001; # that value works nice, but you can try out to lower (but values above 0.005 works baad)
in
{
  programs.niri.settings = {
    animations = {
      enable = false;
      slowdown = 1.0; # bigger value - slower the animations

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
        duration-ms = candy;
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
        duration-ms = candy;
      };

      # utils
      screenshot-ui-open.kind.easing = {
        curve = "cubic-bezier";
        curve-args = easeInOut;
        duration-ms = candy;
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

let
  # curves (works bad with gestures)
  # easing like:
  easeInOut = [ 0.85 0.00 0.25 1.00 ]; # starts very slowly and then incredibly accelerates
  # spring like:
  anticipation = [ 0.25 (-0.50) 0.05 1.00 ]; # accumulates at first and then realeases

  # animation durations
  candy = 750;
  responsive = 375;

  # dampings
  jumpy = 0.70; # eye candy
  tight = 0.75; # responsive feel

  # stiffnesses
  loStiff = 175; # eye candy
  hiStiff = 350; # responsive feel

  # epsilon
  e = 0.00001; # that value works nice, but you can try out to lower (but values above 0.005 works baad)
in
{
  programs.niri.settings = {
    animations = {
      enable = true;
      slowdown = 1.0; # bigger value - slower the animations

      # navigation
      ## workspaces
      workspace-switch.kind.spring = {
        stiffness = hiStiff;
        damping-ratio = tight;
        epsilon = e;
      };
      ## windows
      horizontal-view-movement.kind.spring = {
        stiffness = hiStiff;
        damping-ratio = tight;
        epsilon = e;
      };
      ## overview
      overview-open-close.kind.spring = {
        stiffness = hiStiff;
        damping-ratio = tight;
        epsilon = e;
      };
      ## recent overview - currently doesn't exist in niri nix
      # recent-windows-close.kind.spring = {
      #   stiffness = hiStiff;
      #   damping-ratio = tight;
      #   epsilon = e;
      # };

      # window management
      ## control
      window-open.kind.spring = {
        stiffness = hiStiff;
        damping-ratio = tight;
        epsilon = e;
      };
      window-close.kind.easing = {
        curve = "cubic-bezier";
        curve-args = easeInOut;
        duration-ms = responsive;
      };
      ## window moving
      window-movement.kind.spring = {
        stiffness = hiStiff;
        damping-ratio = tight;
        epsilon = e;
      };
      ## window resize
      window-resize.kind.easing = {
        curve = "cubic-bezier";
        curve-args = easeInOut;
        duration-ms = responsive;
      };

      # utils
      screenshot-ui-open.kind.easing = {
        curve = "cubic-bezier";
        curve-args = easeInOut;
        duration-ms = responsive;
      };

      config-notification-open-close.kind.spring = {
        stiffness = hiStiff;
        damping-ratio = tight;
        epsilon = e;
      };
      exit-confirmation-open-close.kind.spring = {
        stiffness = hiStiff;
        damping-ratio = tight;
        epsilon = e;
      };
    };
  };
}

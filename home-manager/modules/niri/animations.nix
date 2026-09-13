let
  easeInOut = [ 0.85 0.00 0.25 1.00 ];
  anticipation = [ 0.25 (-0.50) 0.05 1.00 ];

  candy = 750;
  responsive = 375;

  jumpy = 0.70;
  tight = 0.75;

  loStiff = 175;
  hiStiff = 350;

  e = 0.001;
in
{
  programs.niri.settings = {
    animations = {
      enable = true;
      slowdown = 1.0;

      workspace-switch.kind.spring = {
        stiffness = hiStiff;
        damping-ratio = tight;
        epsilon = e;
      };
      horizontal-view-movement.kind.spring = {
        stiffness = hiStiff;
        damping-ratio = tight;
        epsilon = e;
      };
      overview-open-close.kind.spring = {
        stiffness = hiStiff;
        damping-ratio = tight;
        epsilon = e;
      };
      # recent-windows-close.kind.spring = {
      #   stiffness = hiStiff;
      #   damping-ratio = tight;
      #   epsilon = e;
      # };

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
      window-movement.kind.spring = {
        stiffness = hiStiff;
        damping-ratio = tight;
        epsilon = e;
      };
      window-resize.kind.easing = {
        curve = "cubic-bezier";
        curve-args = easeInOut;
        duration-ms = responsive;
      };

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

{
  programs.niri.settings = {
    input = {
      keyboard = {
        xkb = {
          layout = "us,ru";
          options = "grp:caps_toggle";
        };
        track-layout = "global";
        repeat-delay = 275;
        repeat-rate = 50;
      };

      touchpad = {
        tap = true;
        dwt = true;
        drag = true;
        click-method = "clickfinger";
        disabled-on-external-mouse = false;
        natural-scroll = true;
        accel-speed = 0.0;
        scroll-method = "two-finger";
        scroll-factor = 0.75;
      };

      mouse = {
        accel-profile = "flat";
      };

      warp-mouse-to-focus = {
        enable = true;
        mode = "center-xy";
      };

      focus-follows-mouse = {
        enable = true;
        max-scroll-amount = "10%";
      };
    };
  };
}

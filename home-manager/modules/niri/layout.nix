{
  programs.niri.settings = {
    layout = {
      background-color = "#292828";
      center-focused-column = "never";
      always-center-single-column = true;
      default-column-width = { proportion = 1. / 2.; };

      preset-column-widths = [
        { proportion = 0.5; }
        { proportion = 0.6667; }
        { proportion = 1.0; }
      ];

      gaps = 5;
      struts = {
        left = -5;
        right = -5;
        top = -5;
        bottom = -5;
      };

      focus-ring.enable = false;
      border = {
        enable = true;
        width = 5;
        active = { color = "#ddc7a1"; };
        inactive = { color = "#665c54"; };
      };

      insert-hint.enable = false;
    };
  };
}

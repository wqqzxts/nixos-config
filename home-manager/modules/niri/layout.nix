{
  programs.niri.settings = {
    layout = {
      background-color = "#292828";
      center-focused-column = "never";
      always-center-single-column = true;
      default-column-width = { proportion = 1. / 2.; };

      preset-column-widths = [
        { proportion = 1. / 2.; }
        { proportion = 2. / 3.; }
        { proportion = 1. / 1.; }
      ];

      gaps = 5;
      struts = {
        left = 7;
        right = 7;
        top = 5;
        bottom = 5;
      };

      focus-ring.enable = false;
      border = {
        enable = true;
        width = 5;
        active = { color = "#ddc7a1"; };
        inactive = { color = "#292828"; };
      };

      insert-hint.enable = false;
    };
  };
}

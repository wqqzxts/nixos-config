{ config, ... }:
let
  colors = config.lib.stylix.colors.withHashtag;
in
{
  programs.niri.settings = {
    layout = {
      background-color = colors.base00;
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

      focus-ring = {
        enable = false;
        width = 5;
        active = { color = colors.base05; };
        inactive = { color = colors.base03; };
      };

      border = {
        enable = true;
        width = 5;
        active = { color = colors.base05; };
        inactive = { color = colors.base03; };
      };

      insert-hint.enable = false;
    };
  };
}

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

      gaps = 15;
      struts = {
        left = -10;
        right = -10;
        top = -15;
        bottom = -5;
      };

      shadow = {
        enable = true;
        softness = 0;
        spread = 5;
        offset = { x = 0; y = 5; };
        color = config.lib.theme.ledge "base05";
        inactive-color = config.lib.theme.ledge "base03";
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

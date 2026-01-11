{ inputs, pkgs, ...}:
let
  hyprPlugPkgs = inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  wayland.windowManager.hyprland = {
    plugins = [
      hyprPlugPkgs.hyprscrolling
    ];

    settings.plugin = {
      hyprscrolling = {
        fullscreen_on_one_column = true;
        column_width = 0.5;
        explicit_column_widths = "0.5,0.667,1.0";
        focus_fit_method = 1;
        follow_focus = true;
        follow_debounce_ms = 100;
      };
    };
  };
}

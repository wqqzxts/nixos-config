{ inputs, pkgs, ...}:
let
  hyprPlugPkgs = inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  wayland.windowManager.hyprland = {
    plugins = [
      # hyprPlugPkgs.hyprscrolling
      # hyprPlugPkgs.hyprexpo # idk why but it doesn't want to work
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
      # hyprexpo = {
      #   columns = 1;
      #   bg_col = "rgba(665C54ff)";
      #   workspace_method = "center current";
      # };
    };
  };
}

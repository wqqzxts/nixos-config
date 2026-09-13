{ config, inputs, pkgs, ... }:
let
  anyrunPkgs = inputs.anyrun.packages.${pkgs.stdenv.hostPlatform.system};
  style = pkgs.replaceVars ./style.css {
    inherit (config.lib.stylix.colors.withHashtag) base00 base03 base05 base08 base0D;
    ledge = config.lib.theme.ledge "base05";
  };
in
{
  programs.anyrun = {
    enable = true;

    config = {
      x.fraction = 0.5;
      y.fraction = 0.5;
      width.fraction = 0.3;
      ignoreExclusiveZones = true;
      layer = "overlay";

      closeOnClick = true;
      showResultsImmediately = true;

      hideIcons = false;
      hidePluginInfo = true;
      maxEntries = 3;

      plugins = [
        anyrunPkgs.applications
        anyrunPkgs.rink
        anyrunPkgs.translate
        anyrunPkgs.stdin
      ];
    };

    extraCss = builtins.readFile style;
  };
}

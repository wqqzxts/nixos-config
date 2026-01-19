{ inputs, pkgs, ... }:
let
  anyrunPkgs = inputs.anyrun.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  programs.anyrun = {
    enable = true;

    config = {
      x.fraction = 0.5;
      y.fraction = 0.45;
      width.fraction = 0.2;
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
      ];
    };

    extraCss = builtins.readFile ./style.css;
  };
}

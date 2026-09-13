{ config, lib, pkgs, ... }:
let
  colors = config.lib.stylix.colors.withHashtag;
  baseNames = map (n: "base0${n}") (lib.stringToCharacters "0123456789ABCDEF");

  colorsScss = pkgs.writeText "eww-colors.scss" (
    lib.concatMapStringsSep "\n" (n: "\$${n}: ${colors.${n}};") baseNames
    + "\n$red-dark: darken($base08, 10%);\n"
  );

  configDir = pkgs.runCommand "eww-config" { } ''
    cp -r ${./.} $out
    chmod -R u+w $out
    rm -f $out/default.nix
    cp ${colorsScss} $out/colors.scss
  '';

  windows = "ewwbar window-power window-clock window-weather window-cava window-language window-status window-battery";
in
{
  programs.eww.enable = true;

  xdg.configFile."eww".source = configDir;

  home.packages = [
    (pkgs.writeShellScriptBin "ewwbar" ''
      eww open-many ${windows}
    '')
  ];

  home.activation.reloadEww = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if ${config.programs.eww.package}/bin/eww ping >/dev/null 2>&1; then
      run ${config.programs.eww.package}/bin/eww reload
    fi
  '';
}

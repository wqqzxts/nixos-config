{ inputs, pkgs, config, ... }:
let
  spicePkgs = inputs.spicetify.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  stylixColor = config.lib.stylix.colors;
in
{
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.text;
    colorScheme = "Gruvbox";
    # TODO: fix custom spotify theme
    # customColorScheme = {
    #   main               = "${stylixColor.base00}";
    #   sidebar            = "${stylixColor.base02}";
    #   player             = "${stylixColor.base02}";
    #   card               = "${stylixColor.base02}";
    #   shadow             = "${stylixColor.base02}";
    #   selected-row       = "${stylixColor.base07}";
    #   button             = "${stylixColor.base0D}";
    #   button-active      = "${stylixColor.base08}";
    #   text               = "${stylixColor.base05}";
    #   subtext            = "${stylixColor.base04}";
    # };
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      keyboardShortcut
    ];
  };
}

{ inputs, pkgs, config, ... }:
let
  spicePkgs = inputs.spicetify.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  c = config.lib.stylix.colors;
in
{
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.text;
    colorScheme = "custom";
    customColorScheme = {
      text               = c.base05;
      subtext            = c.base04;
      main               = c.base00;
      sidebar            = c.base01;
      player             = c.base01;
      card               = c.base02;
      shadow             = c.base00;
      selected-row       = c.base03;
      button             = c.base0D;
      button-active      = c.base0B;
      button-disabled    = c.base03;
      tab-active         = c.base02;
      notification       = c.base02;
      notification-error = c.base08;
      misc               = c.base03;
    };
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      keyboardShortcut
    ];
  };
}

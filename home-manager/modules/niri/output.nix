{ config, ... }:
{
  programs.niri.settings = {
    outputs = {
      eDP-1 = {
        scale = 1.0;
        backdrop-color = config.lib.stylix.colors.withHashtag.base03;
      };
    };
  };
}

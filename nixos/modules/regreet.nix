{ pkgs, ... }:
let
  themePkg = pkgs.gruvbox-material-gtk-theme;
  themePath = "${themePkg}/share/themes/Gruvbox-Material-Dark-HIDPI/gtk-4.0/gtk.css";
in {
  programs.regreet = {
    enable = true;
    extraCss = ''
      @import url("file://${themePath}");
      .background {
        opacity: 0.90;
      }
    '';
    settings = {
      background = {
        path = ../assets/regreet.png;
        fit = "Cover";
      };
      GTK = {
        application_prefer_dark_theme = true;
        cursor_blink = false;
      };
      appearance = {
        # greeting_msg = "nixos.org ☺️ nixos.com 💀";
        greeting_msg = "Night hums softly";
      };
    };
  };
}

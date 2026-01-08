{ pkgs, ... }:
let
  themePkg = pkgs.gruvbox-material-gtk-theme;
  themePath = "${themePkg}/share/themes/Gruvbox-Material-Dark/gtk-4.0/gtk.css";
in {
  programs.regreet = {
    enable = true;
    # @import url("file://${themePath}");
    # extraCss = ''
    #   .background {
    #     opacity: 0.90;
    #   }
    # '';
    settings = {
      background = {
        path = ../assets/regreet.png;
        fit = "Cover";
      };
    };
  };
}

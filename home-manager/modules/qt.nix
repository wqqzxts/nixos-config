{ pkgs, ... }: {
  home.packages = with pkgs; [
    papirus-icon-theme
    pcmanfm-qt
  ];
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      package = pkgs.gruvbox-material-gtk-theme;
      name = "Gruvbox-Material-Dark";
    };
  };
}

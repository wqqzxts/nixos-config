{ pkgs, inputs, ... }: {
  imports = [ inputs.stylix.homeModules.stylix ];

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # text
    corefonts
    dejavu_fonts
    nerd-fonts.iosevka-term
    noto-fonts
    noto-fonts-lgc-plus
    noto-fonts-color-emoji
    ipafont
    # icons
    font-awesome
    powerline-symbols
    nerd-fonts.symbols-only
  ];

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-medium.yaml";


    targets = {
      firefox.enable = false;
      hyprland.enable = false;
      hyprlock.enable = false;
      neovim.enable = false;
      nixvim.enable = false;
      rofi.enable = false;
      swaync.enable = false;
      waybar.enable = false;
    };

    cursor = {
      name = "Capitaine Cursors (Gruvbox)";
      size = 50;
      package = pkgs.capitaine-cursors-themed;
    };

    fonts = {
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-color-emoji;
      };
      monospace = {
        name = "IosevkaTerm Nerd Font Mono";
        package = pkgs.nerd-fonts.iosevka-term;
      };
      sansSerif = {
        name = "Noto Sans";
        package = pkgs.noto-fonts;
      };
      serif = {
        name = "Noto Serif";
        package = pkgs.noto-fonts;
      };
      sizes = {
        terminal = 20;
        applications = 16;
      };
    };

    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    image = ../../nixos/assets/wall-lain.jpg;
  };
}

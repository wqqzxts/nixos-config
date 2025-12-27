{ pkgs, inputs, ... }: {
  imports = [ inputs.stylix.homeModules.stylix ];

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # text
    corefonts
    dejavu_fonts
    jetbrains-mono
    nerd-fonts.hack
    nerd-fonts.fira-code
    nerd-fonts.meslo-lg
    noto-fonts
    noto-fonts-lgc-plus
    noto-fonts-color-emoji
    # icons
    font-awesome
    powerline-symbols
    nerd-fonts.symbols-only
  ];

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";

    targets = {
      bat.enable = false;
      firefox.enable = false;
      hyprland.enable = false;
      hyprlock.enable = false;
      neovim.enable = false;
      nixvim.enable = false;
      waybar.enable = false;
      wofi.enable = false;
    };

    cursor = {
      name = "DMZ-Black";
      size = 24;
      package = pkgs.vanilla-dmz;
    };

    fonts = {
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-color-emoji;
      };
      monospace = {
        # name = "Jetbrains Mono";
        # package = pkgs.jetbrains-mono;
        name = "Hack Nerd Font Mono";
        package = pkgs.nerd-fonts.hack;
        # name = "FiraCode Nerd Font Mono";
        # package = pkgs.nerd-fonts.fira-code;
        # name = "MesloLGS Nerd Font Mono";
        # package = pkgs.nerd-fonts.meslo-lg;
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
        terminal = 14;
        applications = 12;
      };
    };

    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    # backwater by William Wyllie
    image = pkgs.fetchurl {
      url = "https://upload.wikimedia.org/wikipedia/commons/8/81/Charles-william-wyllie-rba_the-backwater_AID483012.jpg";
      sha256 = "ad2274f37741071c2cb07e424c014f9d6ad001f7123af7d52b6528f5b39a42f0";
    };
  };
}

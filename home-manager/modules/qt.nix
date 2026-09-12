{ pkgs, ... }: {
  home.packages = with pkgs; [
    papirus-icon-theme
  ];
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style = {
      # packaged from source: nixpkgs removed gruvbox-material-gtk-theme along
      # with gtk-engine-murrine, which only the (unused) gtk2 part needed
      package = pkgs.stdenvNoCC.mkDerivation {
        pname = "gruvbox-material-gtk-theme";
        version = "unstable-2025-01-17";
        src = pkgs.fetchFromGitHub {
          owner = "TheGreatMcPain";
          repo = "gruvbox-material-gtk";
          rev = "bb306ae972273cbfcbf78f8b772662e8b0678d82";
          hash = "sha256-F3jVvibeov/3ZlIu+m0SmNsX6l1UwunTFKy+CnAOwok=";
        };
        installPhase = ''
          mkdir -p $out/share/themes
          cp -r themes/* $out/share/themes/
        '';
      };
      name = "Gruvbox-Material-Dark";
    };
  };
}

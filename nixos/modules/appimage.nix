{ pkgs, ... }: {
  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      extraPkgs = pkgs: [
        pkgs.double-conversion
        pkgs.libGL
        pkgs.libepoxy
        pkgs.libpng
        pkgs.pcre2

        pkgs.fontconfig
        pkgs.fontconfig
        pkgs.freetype
        pkgs.libxkbcommon
        pkgs.xorg.libX11
        pkgs.xorg.libXcomposite
        pkgs.xorg.libXcursor
        pkgs.xorg.libXdamage
        pkgs.xorg.libXext
        pkgs.xorg.libXfixes
        pkgs.xorg.libXi
        pkgs.xorg.libXrender
        pkgs.xorg.libXtst
        pkgs.xorg.libxcb
      ];
    };
  };
}

{ config, pkgs, ... }:
let
  c = config.lib.stylix.colors.withHashtag;
  cursorName = "Capitaine Cursors (${config.theme.style}-${config.stylix.polarity})";

  capitaineSrc = pkgs.fetchFromGitHub {
    owner = "sainnhe";
    repo = "capitaine-cursors";
    rev = "r5";
    hash = "sha256-M9N/KP/2UD+F1MiD+mXCvAeMfcutEatRerpezUK2hwE=";
  };

  palette = {
    "#fff" = c.base06;
    "#1a1a1a" = c.base01;
    "#ff645d" = c.base08;
    "#ff4332" = c.base08;
    "#ed1515" = c.base08;
    "#fbb114" = c.base09;
    "#ff9508" = c.base09;
    "#f67400" = c.base09;
    "#ffd305" = c.base0A;
    "#fdcf01" = c.base0A;
    "#52cf30" = c.base0B;
    "#3bbd1c" = c.base0B;
    "#11d116" = c.base0B;
    "#18c087" = c.base0C;
    "#14adf6" = c.base0D;
    "#1191f4" = c.base0D;
    "#3daee9" = c.base0D;
    "#ca70e1" = c.base0E;
    "#b452cb" = c.base0E;
    "#959595" = c.base04;
  };

  cursors = pkgs.stdenvNoCC.mkDerivation {
    pname = "capitaine-cursors-base16";
    version = "r5";
    src = capitaineSrc;
    nativeBuildInputs = [ pkgs.resvg pkgs.xcursorgen ];
    dontConfigure = true;

    buildPhase = ''
      runHook preBuild
      svg=src/svg/dark
      for f in $svg/*.svg; do
        sed -i -E ${pkgs.lib.concatStringsSep " " (pkgs.lib.mapAttrsToList (from: to: "-e 's/${from}([^0-9a-fA-F]|$)/@${pkgs.lib.removePrefix "#" to}@\\1/gI'") palette)} "$f"
        sed -i -E 's/@([0-9a-fA-F]{6})@/#\1/g' "$f"
      done

      mkdir -p build
      for scale in 1 1.25 1.5 2 2.5; do
        dim=$(awk "BEGIN { printf \"%d\", 32 * $scale }")
        mkdir -p build/x$scale
        for f in $svg/*.svg; do
          resvg -w "$dim" -h "$dim" "$f" "build/x$scale/$(basename "''${f%.svg}").png"
        done
        for spec in src/config/static/*.spec; do
          read -r xhot yhot < "$spec" || true
          name=$(basename "''${spec%.spec}")
          awk "BEGIN { printf \"%d %d %d x$scale/$name.png\n\", 32 * $scale, $xhot * $scale, $yhot * $scale }" >> "build/$name.in"
        done
        for spec in src/config/animated/*.spec; do
          read -r xhot yhot frames delay < "$spec" || true
          name=$(basename "''${spec%.spec}")
          for ((i = 0; i < frames; i++)); do
            awk "BEGIN { printf \"%d %d %d x$scale/$name-%02d.png $delay\n\", 32 * $scale, $xhot * $scale, $yhot * $scale, $i }" >> "build/$name.in"
          done
        done
      done
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      out_dir="$out/share/icons/${cursorName}"
      mkdir -p "$out_dir/cursors"
      (cd build && for cfg in *.in; do xcursorgen "$cfg" "$out_dir/cursors/''${cfg%.in}"; done)
      while read -r to from; do
        [ -e "$out_dir/cursors/$to" ] || ln -s "$from" "$out_dir/cursors/$to"
      done < src/cursor-aliases
      printf '[Icon Theme]\nName=%s\nComment=Capitaine cursors in the current base16 palette\n' "${cursorName}" > "$out_dir/index.theme"
      runHook postInstall
    '';
  };
in
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    corefonts
    dejavu_fonts
    nerd-fonts.iosevka-term
    nerd-fonts.iosevka-term
    nerd-fonts.iosevka-term-slab
    nerd-fonts.bigblue-terminal
    nerd-fonts.departure-mono
    nerd-fonts.gohufont
    nerd-fonts.jetbrains-mono
    nerd-fonts.monoid
    noto-fonts
    noto-fonts-lgc-plus
    noto-fonts-color-emoji
    ipafont
    kanji-stroke-order-font
    font-awesome
    powerline-symbols
    nerd-fonts.symbols-only
  ];

  stylix = {
    enable = true;

    targets = {
      dunst.enable = false;
      firefox = { enable = true; profileNames = [ "default" ]; colorTheme.enable = true; };
      hyprland.enable = false;
      hyprlock.enable = false;
      neovim.enable = false;
      nixvim = { enable = true; plugin = "base16-nvim"; };
      rofi.enable = false;
      spicetify.enable = false;
      waybar.enable = false;
    };

    cursor = {
      name = cursorName;
      size = 40;
      package = cursors;
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

    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };
  };
}

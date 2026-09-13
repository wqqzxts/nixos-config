{ config, lib, pkgs, ... }:
let
  styles = {
    gruvbox = { dark = "gruvbox-material-dark-medium"; light = "gruvbox-material-light-medium"; };
    ayu = { dark = "ayu-mirage"; light = "ayu-light"; };
    mono = { dark = "grayscale-dark"; light = "grayscale-light"; };
    tokyonight = { dark = "tokyo-night-moon"; light = "tokyo-night-light"; };
    rose-pine = { dark = "rose-pine"; light = "rose-pine-dawn"; };
  };

  default = { style = "gruvbox"; polarity = "dark"; };

  schemeFile = s: "${pkgs.base16-schemes}/share/themes/${s}.yaml";
  wallpaperDir = style: polarity: "${../../assets}/${style}/${polarity}";

  variantName = style: polarity: "${style}-${polarity}";
  variant = style: polarity: {
    theme.style = lib.mkForce style;
    theme.wallpapers = lib.mkForce (wallpaperDir style polarity);
    stylix.polarity = lib.mkForce polarity;
    stylix.base16Scheme = lib.mkForce (schemeFile styles.${style}.${polarity});
  };

  baseNames = map (n: "base0${n}") (lib.stringToCharacters "0123456789ABCDEF");
  styleNames = builtins.attrNames styles;

  themeScript = pkgs.writeShellApplication {
    name = "theme";
    runtimeInputs = with pkgs; [ jq dconf libnotify coreutils findutils procps util-linux neovim-unwrapped ];
    text = ''
      state="$HOME/.config/quickshell/theme.json"
      profiles="$HOME/.local/state/nix/profiles"
      default_variant=${lib.escapeShellArg (variantName default.style default.polarity)}
      styles=(${lib.concatMapStringsSep " " lib.escapeShellArg styleNames})

      current_style()    { jq -r .style    "$state"; }
      current_polarity() { jq -r .polarity "$state"; }

      base_generation() {
        local g
        while read -r g; do
          if [ -d "$g/specialisation" ]; then echo "$g"; return; fi
        done < <(find "$profiles" -maxdepth 1 -name 'home-manager-*-link' -printf '%T@ %p\n' | sort -rn | cut -d' ' -f2-)
        echo "theme: no generation with specialisations found, run home-manager switch first" >&2
        exit 1
      }

      activate() {
        local style="$1" polarity="$2" name="$1-$2" base act
        base=$(base_generation)
        if [ "$name" = "$default_variant" ]; then act="$base/activate"; else act="$base/specialisation/$name/activate"; fi
        [ -x "$act" ] || { echo "theme: unknown variant $name" >&2; exit 1; }
        shell-ipc transition begin >/dev/null 2>&1 || true
        sleep 0.4
        "$act" > "$HOME/.cache/theme-activate.log" 2>&1

        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-$polarity'"
        dconf write /org/gnome/desktop/interface/gtk-theme "'$(jq -r .gtkTheme "$state")'"
        shell-ipc theme reload >/dev/null 2>&1 || true
        systemctl --user restart wpaperd.service 2>/dev/null || true
        tmux source-file "$HOME/.config/tmux/tmux.conf" 2>/dev/null || true
        for s in "''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"/nvim.*; do
          [ -S "$s" ] && nvim --server "$s" --remote-send "<Cmd>lua ThemeReload()<CR>" >/dev/null 2>&1 || true
        done
        if pgrep -f '/share/spotify/.spotify-wrapped' >/dev/null 2>&1; then
          pkill -f '/share/spotify/.spotify-wrapped' || true
          sleep 1
          setsid -f spotify >/dev/null 2>&1 || true
        fi
        shell-ipc transition end >/dev/null 2>&1 || true
        notify-send -a theme "Theme" "$style $polarity"
      }

      case "''${1:-status}" in
        status) echo "$(current_style) $(current_polarity)" ;;
        list)   for s in "''${styles[@]}"; do echo "$s dark"; echo "$s light"; done ;;
        set)    activate "$2" "$3" ;;
        toggle) p=$(current_polarity); [ "$p" = dark ] && p=light || p=dark; activate "$(current_style)" "$p" ;;
        next)   cur=$(current_style); n=''${#styles[@]}
                for i in "''${!styles[@]}"; do
                  if [ "''${styles[$i]}" = "$cur" ]; then activate "''${styles[$(( (i + 1) % n ))]}" "$(current_polarity)"; exit 0; fi
                done
                activate "''${styles[0]}" "$(current_polarity)" ;;
        *) echo "usage: theme [status|list|toggle|next|set <style> <dark|light>]" >&2; exit 1 ;;
      esac
    '';
  };
in
{
  options.theme = {
    style = lib.mkOption { type = lib.types.str; description = "Name of the active style."; };
    wallpapers = lib.mkOption { type = lib.types.path; description = "Wallpaper folder of the active variant."; };
  };

  config = {
    theme.style = default.style;
    theme.wallpapers = wallpaperDir default.style default.polarity;
    stylix.polarity = default.polarity;
    stylix.base16Scheme = schemeFile styles.${default.style}.${default.polarity};

    specialisation = lib.listToAttrs (lib.concatMap (style:
      map (polarity: lib.nameValuePair (variantName style polarity) { configuration = variant style polarity; })
        (builtins.filter (polarity: !(style == default.style && polarity == default.polarity)) [ "dark" "light" ])
    ) styleNames);

    xdg.configFile."quickshell/theme.json".text = builtins.toJSON {
      style = config.theme.style;
      styles = styleNames;
      polarity = config.stylix.polarity;
      gtkTheme = if config.stylix.polarity == "dark" then "${config.gtk.theme.name}-dark" else config.gtk.theme.name;
      colors = lib.genAttrs baseNames (n: config.lib.stylix.colors.withHashtag.${n});
    };

    home.packages = [ themeScript ];
  };
}

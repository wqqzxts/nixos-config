{ pkgs, ... }: {
  programs.eww.enable = true;

  # configDir was removed from home-manager and its replacements (yuckConfig/
  # scssConfig) can't handle a multi-file config, so link the directory directly
  xdg.configFile."eww".source = ./.;

  # real executable so niri autostart (spawn can't see shell aliases) and the
  # terminal both work
  home.packages = [
    (pkgs.writeShellScriptBin "ewwbar" ''
      eww open ewwbar && eww open window-power && eww open window-clock && eww open window-weather && eww open window-cava && eww open window-language && eww open window-status && eww open window-battery
    '')
  ];
}

{ pkgs, ... }: {
  programs.eww = {
    enable = true;
    configDir = ./.;
  };
}

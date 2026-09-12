{ pkgs, user, ... }: {
  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;
    users.${user} = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "docker"];
    };
  };

  # Autologin only on tty1 and only once per boot. Every other VT, and tty1
  # after the compositor exits, asks for a password. The zsh profile then
  # exec's niri-session on tty1 and hyprlock locks the session at startup.
  services.getty = {
    autologinUser = user;
    autologinOnce = true;
  };
}

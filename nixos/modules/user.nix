{ pkgs, user, ... }: {
  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;
    users.${user} = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "docker"];
    };
  };

  # regreet wayland gui setup
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        user = "greeter";
      };
    };
  };

  /*
  minimal setup with tui
  in case you want use it do not forget to comment ./regreet.nix in ./default.nix
  and finally delete theme package in ../../hosts/<your_hostname>/local-packages.nix
  */
  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
  #       user = "greeter";
  #     };
  #   };
  # };
}

{ homeStateVersion, user, ... }: {
  imports = [
    ./modules
    ./home-packages.nix
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;
  };

  services.udiskie.enable = true;
  services.udiskie.tray = "never";

  xdg.mimeApps = {
    defaultApplications = {
      enable = true;
      "inode/directory" = [ "yazi.desktop" ];
      "application/pdf" = [ "zathura.desktop" ];
    };
  };
}

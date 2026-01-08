{ inputs, homeStateVersion, user, pkgs, lib, ... }: {
  imports = [
    ./modules
    ./home-packages.nix
  ];

  services.udiskie.enable = true;
  services.udiskie.tray = "never";

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;
  };

  xdg.mimeApps = {
    defaultApplications = {
      enable = true;
      "inode/directory" = [ "yazi.desktop" ];
      "application/pdf" = [ "zathura.desktop" ];
    };
  };
}

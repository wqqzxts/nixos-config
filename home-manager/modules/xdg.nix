{ user, ... }: {
  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      desktop = "/home/${user}/desktop";
      documents = "/home/${user}/documents";
      download = "/home/${user}/downloads";
      pictures = "/home/${user}/pictures";
    };

    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = [ "pcmanfm.desktop" ];

        "application/pdf" = [ "zathura.desktop" ];

        "image/*" = [ "imv.desktop" ];
        "audio/*" = [ "mpv.desktop" ];
        "video/*" = [ "mpv.desktop" ];

        "application/x-bittorrent" = [ "org.qbittorrent.qBittorrent.desktop" ];

        "application/x-ipynb+json" = [ "vscodium.desktop" ];
      };
    };
  };
}

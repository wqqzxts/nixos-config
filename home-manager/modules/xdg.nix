{ user, ... }: {
  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      download = "/home/${user}/downloads";
      pictures = "/home/${user}/pictures";
    };

    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = [ "yazi.desktop" ];

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

{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = [ "/home/wq/nixos-config/nixos/assets/wall-lain.jpg" ];
      wallpaper = [
        {
          monitor = "eDP-1";
          path = "/home/wq/nixos-config/nixos/assets/wall-lain.jpg";
        }
      ];
    };
  };
}

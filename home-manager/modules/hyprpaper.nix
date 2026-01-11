{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = [ "/home/wq/nixos-config/assets/wall-lain.jpg" ];
      # you might need to change the monitor name, to find out yours use comand: "hyprctl monitors"
      wallpaper = [
        {
          monitor = "eDP-1";
          path = "/home/wq/nixos-config/assets/wall-lain.jpg";
        }
      ];
    };
  };
}

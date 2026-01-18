{ user, ...}: {
  services.hyprpaper = {
    enable = true;
    # settings = {
    #   ipc = "on";
    #   splash = false;
    #   preload = [ "/home/${user}/nixos-config/assets/wall-lain.jpg" ];
    #   # you might need to change the monitor name, to find out yours use comand: "niri msg outputs"
    #   wallpaper = [
    #     {
    #       monitor = "eDP-1";
    #       path = "/home/${user}/nixos-config/assets/wall-lain.jpg";
    #     }
    #   ];
    # };
  };
}

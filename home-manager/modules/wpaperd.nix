{ config, ... }: {
  services.wpaperd = {
    enable = true;
    settings = {
      eDP-1 = {
        path = config.theme.wallpapers;
        duration = "30s";
        mode = "center";
        transition-time = 650;
      };
    };
  };
}

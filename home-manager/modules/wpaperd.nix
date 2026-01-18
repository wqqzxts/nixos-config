{
  services.wpaperd = {
    enable = true;
    settings = {
      eDP-1 = {
        path = ../../assets;
        duration = "30s";
        mode = "fit";
        transition-time = 650;
      };
    };
  };
}

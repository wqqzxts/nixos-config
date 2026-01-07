{
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      control-center-radius = 0;
      fit-to-screen = true;
      layer-shell = true;
      layer = "overlay";
      control-center-layer = "overlay";
      cssPriority = "user";
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      image-visibility = "when-available";
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;

      widgets = [
        "inhibitors"
        "dnd"
        "mpris"
        "notifications"
      ];
      widget-config = {
        dnd = {
          text = "󰂛";
        };
        mpris = {
          image-size = 96;
          image-radius = 0;
          blur = true;
          blacklist = [ "spotify" "firefox"]; # well there's two instances by default the dbus and specific application so i decided to block the player isntances of apps
        };
      };
    };
    style = ./style.css;
  };
}

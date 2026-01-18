{
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 180;
        command = "brightnessctl -s set 30";
        resumeCommand = "brightnessctl -r";
      }
      {
        timeout = 300;
        command = "loginctl lock-session";
      }
      {
        timeout = 600;
        command = "niri msg output off";
        resumeCommand = "niri msg output on";
      }
      {
        timeout = 1200;
        command = "systemctl suspend";
      }
    ];
    events = {
      before-sleep = "loginctl lock-session";
      after-resume = "niri msg output on";
    };
  };
}

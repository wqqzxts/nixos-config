{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "sleep";
        action = "systemctl suspend";
        text = "󰤄";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "󰐥";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "󰜉";
      }
    ];
    style = ./style.css;
  };
}

{
  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 50;
        spacing = 5;
        margin-left = 3;
        margin-right = 3;
        margin-top = 7;
        modules-left = ["custom/launcher" "hyprland/workspaces" "mpris"];
        modules-center = ["clock"];
        modules-right = ["hyprland/language" "custom/weather" "pulseaudio" "battery" "tray"];

        "custom/launcher" = {
          format = "";
          on-click = "wofi -S drun";
          tooltip = false;
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          show-special = true;
          special-visible-only = true;
          all-outputs = false;
          format = "{icon}";
          format-icons = {
            "1" = "一";
            "2" = "二";
            "3" = "三";
            "4" = "四";
            "5" = "五";
          };

          persistent-workspaces = {
            "*" = 5;
          };
        };

        "mpris" = {
          interval = 0.5;
          format = "<span color='#a9b665'>{status_icon}</span> {artist} | {title}";
          format-disconnected = "Disconnected";
          format-stopped = "{status_icon} Stopped";
          ellipsis = "…";
          title-len = 15;
          player-icons = {
            default = "▶";
          };
          status-icons = {
            paused = "";
            playing = "";
            stopped = "";
          };
          tooltip = false;
        };

        "clock" = {
          format = "{:%a %d | %I:%M %p}";
          interval = 1;
          on-click = ../eww/calendar.sh;
          tooltip = false;
        };

        "hyprland/language" = {
          format-en = "US";
          format-ru = "RU";
          min-length = 5;
          tooltip = false;
        };

        "custom/weather" = {
          format = " {} ";
          exec = "curl -s 'wttr.in/Moscow?m&format=%t'";
          interval = 5000;
          class = "weather";
          tooltip = false;
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}% ";
          format-muted = "";
          format-icons = {
            "headphones" = "";
            "default" = ["" ""];
          };
          on-click = "pavucontrol";
          tooltip = false;
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 10;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-icons = ["" "" "" "" ""];
          tooltip = false;
        };

        "tray" = {
          icon-size = 23;
          spacing = 5;
        };
      };
    };
  };
}

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
        modules-left = ["custom/launcher" "niri/workspaces" "mpris" "cava"];
        modules-center = ["clock"];
        modules-right = ["hyprland/language" "custom/weather" "pulseaudio" "battery" "tray"];

        "custom/launcher" = {
          format = "";
          on-click = "wlogout";
          tooltip = false;
        };

        "niri/workspaces" = {
          all-outputs = false;
          format = "{icon}";
          format-icons = {
            "1" = "一";
            "2" = "二";
            "3" = "三";
            "4" = "四";
            "5" = "五";
          };
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
            "magic" = "上";
          };

          persistent-workspaces = {
            "*" = 3;
          };
        };

        "mpris" = {
          interval = 0.5;
          format = "<span color='#a9b665'>{status_icon}</span> {artist} | {title}";
          format-disconnected = "";
          format-stopped = "{status_icon} Stopped";
          ellipsis = "…";
          title-len = 20;
          player-icons = {
            default = "";
          };
          status-icons = {
            paused = "";
            playing = "";
            stopped = "";
          };
          tooltip = false;
        };

        "cava" = {
          framerate = 60;
          bars = 6;
          bar_delimiter = 0;
          method = "pipewire";
          noise_reduction = 0.85;
          waves = true;
          sleep_timer = 1;
          hide_on_silence = true;
          format-icons = [" " "▂" "▃" "▄" "▅" "▆" "▇" "█"];
        };

        "clock" = {
          # format = "{:%a %d | %I:%M %p}";
          format = "{:%H:%M}";
          interval = 1;
          on-click = ../eww/calendar/calendar.sh;
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
          exec = "curl -s 'wttr.in/London?m&format=%t'";
          interval = 600;
          class = "weather";
          tooltip = false;
        };

        "pulseaudio" = {
          format = "{icon} {volume}";
          format-bluetooth = "{icon} {volume} ";
          format-muted = "";
          format-icons = {
            "headphones" = "";
            "default" = [""];
          };
          on-click = "pavucontrol";
          tooltip = false;
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 10;
          };
          format = "{icon} {capacity}";
          format-charging = " {capacity}";
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

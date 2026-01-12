{
  programs.niri.settings = {
    binds = {
      # applications
      "Mod+T" = { action.spawn = [ "alacritty" ]; repeat = false; };
      "Mod+Y" = { action.spawn-sh = [ "yazi" ]; repeat = false; };
      "Mod+D" = { action.spawn = [ "rofi" "-show" "drun" ]; repeat = false; };
      "Mod+V" = { action.spawn = [ "sh" "-c" "cliphist list | rofi -dmenu | cliphist decode | wl-copy" ]; repeat = false; };
      "Mod+E" = { action.spawn = [ "bemoji" "-cn" ]; repeat = false; };

      # utilities
      "Mod+P".action.spawn = [ "hyprpicker" "-an" ];
      "Print".action.screenshot = [ ];

      # widgets
      "Mod+B" = { action.spawn = [ "pkill" "-SIGUSR1" "waybar" ]; repeat = false; };
      "Mod+N" = { action.spawn = [ "swaync-client" "-t" ]; repeat = false; };
      "Mod+Shift+Escape" = { action.spawn = [ "wlogout" ]; repeat = false; };
      "Mod+Escape" = { action.spawn = [ "loginctl" "lock-session" ]; repeat = false; };

      # window management
      "Mod+Q" = { action.close-window = [ ]; repeat = false; };
      "Mod+F" = { action.toggle-window-floating = [ ]; repeat = false; };

      ## window moving
      "Mod+Shift+H" = { action.move-column-left = [ ]; repeat = false; };
      "Mod+Shift+L" = { action.move-column-right = [ ]; repeat = false; };
      "Mod+Shift+J" = { action.move-window-down = [ ]; repeat = false; };
      "Mod+Shift+K" = { action.move-window-up = [ ]; repeat = false; };

      ## column management
      "Super+Shift+Alt+H" = { action.consume-window-into-column = [ ]; repeat = false; };
      "Super+Shift+Alt+L" = { action.expel-window-from-column = [ ]; repeat = false; };

      ## window resizing
      "Mod+Ctrl+H".action.set-column-width = "-10%";
      "Mod+Ctrl+J".action.set-window-height = "-60";
      "Mod+Ctrl+K".action.set-window-height = "+60";
      "Mod+Ctrl+L".action.set-column-width = "+10%";

      "Mod+Ctrl+U".action.maximize-column = [ ];
      "Mod+Ctrl+R".action.set-column-width = "50%";
      "Mod+Ctrl+F".action.fullscreen-window = [ ];

      ## window navigation
      "Mod+H".action.focus-column-left = [ ];
      "Mod+J".action.focus-window-down = [ ];
      "Mod+K".action.focus-window-up = [ ];
      "Mod+L".action.focus-column-right = [ ];

      "Mod+Tab" = { action.toggle-overview = [ ]; repeat = false; };

      # workspace management
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;

      "Mod+Shift+1".action.move-window-to-workspace = 1;
      "Mod+Shift+2".action.move-window-to-workspace = 2;
      "Mod+Shift+3".action.move-window-to-workspace = 3;
      "Mod+Shift+4".action.move-window-to-workspace = 4;
      "Mod+Shift+5".action.move-window-to-workspace = 5;

      # laptop keys
      "XF86AudioRaiseVolume".action.spawn = [ "wpctl" "set-volume" "-l" "1" "@DEFAULT_AUDIO_SINK@" "5%+" ];
      "XF86AudioLowerVolume".action.spawn = [ "wpctl" "set-volume" "-l" "1" "@DEFAULT_AUDIO_SINK@" "5%-" ];
      "XF86AudioMute".action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
      "XF86AudioMicMute".action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle" ];

      "XF86MonBrightnessUp".action.spawn = [ "brightnessctl" "s" "10%+" ];
      "XF86MonBrightnessDown".action.spawn = [ "brightnessctl" "s" "10%-" ];

      "XF86AudioNext".action.spawn = [ "playerctl" "next" ];
      "XF86AudioPause".action.spawn = [ "playerctl" "play-pause" ];
      "XF86AudioPlay".action.spawn = [ "playerctl" "play-pause" ];
      "XF86AudioPrev".action.spawn = [ "playerctl" "previous" ];
    };
  };
}

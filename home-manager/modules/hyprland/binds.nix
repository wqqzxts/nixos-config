{ pkgs, ... }: {
  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mainMod,       T, exec, $terminal"
      "$mainMod,       Q, killactive,"
      "$mainMod,       ESCAPE, exec, loginctl lock-session"
      "$mainMod SHIFT, ESCAPE, exec, wlogout,"
      "$mainMod,       R, exec, $fileManager"
      "$mainMod,       D, togglefloating,"
      "$mainMod,       SPACE, exec, $menu"
      "$mainMod,       E, exec, bemoji -cn"
      "$mainMod,       V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
      "$mainMod,       B, exec, pkill -SIGUSR1 waybar"
      "$mainMod SHIFT, B, exec, pkill -SIGUSR2 waybar"
      "$mainMod,       P, exec, hyprpicker -an"
      "$mainMod,       N, exec, swaync-client -t"
      ", Print, exec, grimblast --notify --freeze copysave area"

      # moving focus
      "$mainMod, h, movefocus, l"
      "$mainMod, l, movefocus, r"
      "$mainMod, k, movefocus, u"
      "$mainMod, j, movefocus, d"

      # moving windows
      "$mainMod SHIFT, h,  swapwindow, l"
      "$mainMod SHIFT, l, swapwindow, r"
      "$mainMod SHIFT, k,    swapwindow, u"
      "$mainMod SHIFT, j,  swapwindow, d"

      # resizing windows                 X  Y
      "$mainMod CTRL, h,  resizeactive, -60 0"
      "$mainMod CTRL, l, resizeactive,  60 0"
      "$mainMod CTRL, k,    resizeactive,  0 -60"
      "$mainMod CTRL, j,  resizeactive,  0  60"

      # switching workspaces
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"

      # noving windows to workspaces
      "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
      "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
      "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
      "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
      "$mainMod SHIFT, 5, movetoworkspacesilent, 5"

      # scratchpad
      "$mainMod,       F, togglespecialworkspace,  magic"
      "$mainMod SHIFT, F, movetoworkspace, special:magic"
    ];

    # move/resize windows with mainMod + lmb/rmb and dragging
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    # volume & brightness
    bindel = [
      ",XF86AudioRaiseVolume,  exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute,         exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute,      exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      "$mainMod, bracketright, exec, brightnessctl s 10%+"
      "$mainMod, bracketleft,  exec, brightnessctl s 10%-"
    ];

    # audio playback
    bindl = [
      ", XF86AudioNext,  exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay,  exec, playerctl play-pause"
      ", XF86AudioPrev,  exec, playerctl previous"
    ];
  };
}

{ pkgs, ... }: {
  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mainMod,       q,       killactive,"
      "$mainMod,       f,       togglefloating,"
      "$mainMod,       t,       exec, $terminal"
      "$mainMod,       y,       exec, $fileManager"
      "$mainMod,       d,       exec, $menu"
      "$mainMod,       ESCAPE,  exec, loginctl lock-session"
      "$mainMod SHIFT, ESCAPE,  exec, wlogout,"
      "$mainMod,       e,       exec, bemoji -cn"
      "$mainMod,       v,       exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
      "$mainMod,       b,       exec, pkill -SIGUSR1 waybar"
      "$mainMod SHIFT, b,       exec, pkill -SIGUSR2 waybar"
      "$mainMod,       p,       exec, hyprpicker -an"
      "$mainMod,       n,       exec, swaync-client -t"
      ",               PRINT,   exec, grimblast --notify --freeze copysave area"

      # window resize
      "$mainMod CTRL, k,  resizeactive, 0    -60"
      "$mainMod CTRL, j,  resizeactive, 0    60"

      # switching workspaces
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"

      # moving windows to workspaces
      "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
      "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
      "$mainMod SHIFT, 3, movetoworkspacesilent, 3"

      # scratchpad
      "$mainMod,       s,	togglespecialworkspace, magic"
      "$mainMod SHIFT, s,	movetoworkspace,        special:magic"

      # scrolling layout
      "$mainMod,  h,  layoutmsg,  focus l"
      "$mainMod,  l,  layoutmsg,  focus r"
      "$mainMod,  k,  layoutmsg,  focus u"
      "$mainMod,  j,  layoutmsg,  focus d"

      "$mainMod SHIFT,  l,  layoutmsg,	movewindowto r"
      "$mainMod SHIFT,  h,  layoutmsg,	movewindowto l"
      "$mainMod SHIFT,  k,  layoutmsg,	movewindowto u"
      "$mainMod SHIFT,  j,  layoutmsg,	movewindowto d"

      "$mainMod CTRL,   l,  exec,	hyprctl dispatch layoutmsg colresize +0.1"
      "$mainMod CTRL,   h,  exec,	hyprctl dispatch layoutmsg colresize -0.1"

      "$mainMod SHIFT,  f,  layoutmsg,  fit active"
    ];

    # move/resize windows with mainMod + lmb/rmb and dragging
    bindm = [
      "$mainMod,  mouse:272, movewindow"
      "$mainMod,  mouse:273, resizewindow"
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

{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";

    bind = [
      # applications
      "$mainMod,       T,       exec, $terminal"
      "$mainMod,       Y,       exec, $fileManager"
      "$mainMod,       D,       exec, $menu"
      "$mainMod,       V,       exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
      "$mainMod,       E,       exec, bemoji -cn"

      # utilities
      "$mainMod,       P,       exec, hyprpicker -an"
      "                ,PRINT,  exec, grimblast --notify --freeze copysave area"

      # widgets
      "$mainMod,       B,       exec, pkill -SIGUSR1 waybar"
      "$mainMod,       N,       exec, swaync-client -t"
      "$mainMod SHIFT, ESCAPE,  exec, wlogout,"
      "$mainMod,       ESCAPE,  exec, loginctl lock-session"

      # window management
      "$mainMod,       Q,       killactive,"
      "$mainMod,       F,       togglefloating,"

      ## window moving
      "$mainMod SHIFT,  l,  layoutmsg,	movewindowto r"
      "$mainMod SHIFT,  h,  layoutmsg,	movewindowto l"
      "$mainMod SHIFT,  k,  layoutmsg,	movewindowto u"
      "$mainMod SHIFT,  j,  layoutmsg,	movewindowto d"

      ## column management
      "$mainMod SHIFT, P,  layoutmsg,    promote"


      ## window resizing
      "$mainMod CTRL, K,  resizeactive,                                      0 -60"
      "$mainMod CTRL, J,  resizeactive,                                      0 60"
      "$mainMod CTRL, L,  exec,         hyprctl dispatch layoutmsg colresize +0.1"
      "$mainMod CTRL, H,  exec,         hyprctl dispatch layoutmsg colresize -0.1"

      "$mainMod CTRL, U,  layoutmsg,    fit active"
      "$mainMod CTRL, R,  exec,         hyprctl dispatch layoutmsg colresize 0.5"
      "$mainMod CTRL, F,  exec,         hyprctl dispatch fullscreen          0"

      ## window navigation
      "$mainMod,  H,  layoutmsg,  focus l"
      "$mainMod,  L,  layoutmsg,  focus r"
      "$mainMod,  K,  layoutmsg,  focus u"
      "$mainMod,  J,  layoutmsg,  focus d"

      # workspace management
      "$mainMod,       1, workspace,                                     1"
      "$mainMod,       2, workspace,                                     2"
      "$mainMod,       3, workspace,                                     3"

      "$mainMod SHIFT, 1, layoutmsg, movecoltoworkspace, 1"
      "$mainMod SHIFT, 2, layoutmsg, movecoltoworkspace, 2"
      "$mainMod SHIFT, 3, layoutmsg, movecoltoworkspace, 3"

      # scratchpad
      "$mainMod,       S,	togglespecialworkspace, magic"
      "$mainMod SHIFT, S,	movetoworkspace,        special:magic"
    ];

    # move/resize windows with mainMod + lmb/rmb and dragging
    bindm = [
      "$mainMod,  mouse:272, movewindow"
      "$mainMod,  mouse:273, resizewindow"
    ];

    # laptop keys
    bindel = [
      ",XF86AudioRaiseVolume,    exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume,    exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute,           exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute,        exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86MonBrightnessUp ,   exec, brightnessctl s 10%+"
      ",XF86MonBrightnessDown,  exec, brightnessctl s 10%-"
    ];

    bindl = [
      ", XF86AudioNext,  exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay,  exec, playerctl play-pause"
      ", XF86AudioPrev,  exec, playerctl previous"
    ];
  };
}

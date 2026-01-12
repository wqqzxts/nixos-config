{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # float
      "match:title ^(Choose wallpaper)(.*)$, center on"
      "match:title ^(Choose wallpaper)(.*)$, float on"
      "match:title ^(Choose wallpaper)(.*)$, size (monitor_w*.60) (monitor_h*.65)"
      "match:title ^(Open File)(.*)$, center on"
      "match:title ^(Open File)(.*)$, float on"
      "match:title ^(Open File)(.*)$, size (monitor_w*.45) (monitor_h*.45)"
      "match:title ^(Select a File)(.*)$, center on"
      "match:title ^(Select a File)(.*)$, float on"
      "match:title ^(Select a File)(.*)$, size (monitor_w*.45) (monitor_h*.45)"
      "match:title ^(Open Folder)(.*)$, center on"
      "match:title ^(Open Folder)(.*)$, float on"
      "match:title ^(Open Folder)(.*)$, size (monitor_w*.45) (monitor_h*.45)"
      "match:title ^(Save As)(.*)$, center on"
      "match:title ^(Save As)(.*)$, float on"
      "match:title ^(Save As)(.*)$, size (monitor_w*.45) (monitor_h*.45)"
      "match:title ^(Library)(.*)$, center on"
      "match:title ^(Library)(.*)$, float on"
      "match:title ^(Library)(.*)$, size (monitor_w*.45) (monitor_h*.45)"
      "match:title ^(File Upload)(.*)$, center on"
      "match:title ^(File Upload)(.*)$, float on"
      "match:title ^(File Upload)(.*)$, size (monitor_w*.45) (monitor_h*.45)"
      "match:title ^(.*)(wants to save)$, center on"
      "match:title ^(.*)(wants to save)$, float on"
      "match:title ^(.*)(wants to save)$, size (monitor_w*.45) (monitor_h*.45)"
      "match:title ^(.*)(wants to open)$, center on"
      "match:title ^(.*)(wants to open)$, float on"
      "match:title ^(.*)(wants to open)$, size (monitor_w*.45) (monitor_h*.45)"

      "match:class ^(org.pulseaudio.pavucontrol)$, center on"
      "match:class ^(org.pulseaudio.pavucontrol)$, float on"
      "match:class ^(org.pulseaudio.pavucontrol)$, size (monitor_w*.45) (monitor_h*.45)"
      "match:class ^(Throne)$, center on"
      "match:class ^(Throne)$, float on"
      "match:class ^(Throne)$, size (monitor_w*.45) (monitor_h*.45)"
      "match:class ^(.blueman-manager-wrapped)$, center on"
      "match:class ^(.blueman-manager-wrapped)$, float on"
      "match:class ^(.blueman-manager-wrapped)$, size (monitor_w*.45) (monitor_h*.45)"
      "match:class ^(ueberzugpp)(.*)$, float on"
      "match:class ^(ueberzugpp)(.*)$, no_anim 1"
      "match:class ^(ueberzugpp)(.*)$, no_focus 1"
      "match:class ^(ueberzugpp)(.*)$, border_size 0"

      # picture in picture
      "match:title ^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$, float on"
      "match:title ^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$, keep_aspect_ratio on"
      "match:title ^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$, move (monitor_w*.73) (monitor_h*.72)"
      "match:title ^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$, size (monitor_w*.25) (monitor_h*.25)"
      "match:title ^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$, float on"
      "match:title ^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$, pin on"

      # tearing
      "match:title .*\.exe, immediate on"
      "match:title .*minecraft.*, immediate on"
      "match:class ^(steam_app).*, immediate on"
    ];
  };
}

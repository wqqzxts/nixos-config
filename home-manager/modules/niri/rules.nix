{
  programs.niri.settings = {
    window-rules = [
      {
        opacity = 0.975;
        draw-border-with-background = false;
      }
      {
        matches = [
          { title = "^(Open File|Select a File|Open Folder|Save As|Library|File Upload|Choose Files|Mini App:|Sign in).*$"; }
          { title = "^.*(wants to save|wants to open)$"; }
          { app-id = "^(org.pulseaudio.pavucontrol|Throne|.blueman-manager-wrapped)$"; }
        ];
        open-floating = true;
        default-column-width = { proportion = 0.50; };
        default-window-height = { proportion = 0.50; };
      }

      {
        matches = [ { title = "^(Choose wallpaper).*$"; } ];
        open-floating = true;
        default-column-width = { proportion = 0.75; };
        default-window-height = { proportion = 0.50; };
      }
      {
        matches = [ { title = "^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture).*$"; } ];
        open-floating = true;
        default-column-width = { proportion = 0.25; };
        default-window-height = { proportion = 0.25; };
      }

      {
        matches = [
          { app-id = "^(ueberzugpp).*$"; }
          { title = "^(Media viewer).*$"; }
        ];
        open-floating = true;
      }
    ];
  };
}

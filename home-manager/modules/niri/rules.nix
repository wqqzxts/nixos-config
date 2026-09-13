{ inputs, options, ... }:
let
  kdl = inputs.niri.lib.kdl;
in
{
  programs.niri.config = options.programs.niri.config.default ++ [
    (kdl.node "blur" [ ] [
      (kdl.leaf "passes" [ 2 ])
      (kdl.leaf "offset" [ 3.0 ])
      (kdl.leaf "noise" [ 0.02 ])
      (kdl.leaf "saturation" [ 1.0 ])
    ])
    (kdl.node "window-rule" [ ] [
      (kdl.node "background-effect" [ ] [ (kdl.leaf "blur" [ true ]) ])
    ])
  ];

  programs.niri.settings = {
    window-rules = [
      {
        opacity = 0.9;
        draw-border-with-background = false;
      }
      {
        matches = [
          { title = "^(Open File|Select a File|Open Folder|Save As|Save File|Library|File Upload|Choose Files|Mini App:|Sign in).*$"; }
          { title = "^.*(wants to save|wants to open)$"; }
          { app-id = "^(org.pulseaudio.pavucontrol|Throne|.blueman-manager-wrapped|imv|Clash-verge|org.gnome.Nautilus)$"; }
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
          # { app-id = "^(ueberzugpp).*$"; }
          { title = "^(Media viewer).*$"; }
        ];
        open-floating = true;
      }

      {
        matches = [ { app-id = "^ueberzugpp_"; } ];
        border.enable = false;
        focus-ring.enable = false;
      }
    ];
  };
}

{
  programs.rofi = {
    enable = true;
    font = "IosevkaTerm Nerd Font Bold 20";
    extraConfig = {
      modi = "drun,filebrowser";
      show-icons = true;
      display-drun = " ";
      display-run = " ";
      display-filebrowser = " ";
      display-window = " ";
      drun-display-format = "{name}";
      window-format = "{w} · {c} · {t}";
    };
    theme = "${./config.rasi}";
  };
}

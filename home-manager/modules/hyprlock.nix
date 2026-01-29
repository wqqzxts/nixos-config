{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
      };

      label = {
        text = "$TIME";
        font_family = "IosevkaTerm Nerd Font Mono";
        font_weight = "bold";
        font_size = 160;
        color = "rgba(221, 199, 161, 1.0)";
        halign = "center";
        valign = "center";

        shadow_passes = 0;
      };

      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          size = "200, 50";
          position = "0, -200";
          rounding = 0;
          dots_center = true;
          font_color = "rgb(221, 199, 161)";
          inner_color = "rgb(102, 92, 84)";
          outer_color = "rgb(221, 199, 161)";
          outline_thickness = 5;
          placeholder_text = "not an arch btw";
          shadow_passes = 0;
        }
      ];
    };
  };
}

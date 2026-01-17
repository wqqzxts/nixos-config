{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        origin = "top-right";
        offset = "(10,10)";
        width = "(200,400)";
        height = 300;
        font = "monospace 20";

        corner_radius = 0;
        frame_width = 5;
        gap_size = 5;
        padding = 10;
        horizontal_padding = 10;
        text_icon_padding = 10;
        frame_color = "#ddc7a1";

        notification_limit = 5;
        indicate_hidden = true;
        stack_duplicates = true;
        hide_duplicate_count = false;

        icon_position = "left";
        min_icon_size = 64;
        max_icon_size = 64;

        mouse_left_click = "do_action";
        mouse_middle_click = "close_current";
        mouse_right_click = "close_all";
      };

      urgency_normal = {
        background = "#292828";
        foreground = "#ddc7a1";
        frame_color = "#a9b665";
        timeout = 10;
      };

      urgency_critical = {
        background = "#292828";
        foreground = "#ddc7a1";
        frame_color = "#ea6962";
        timeout = 0;
      };
    };
  };
}

{
  programs.nixvim = {
    plugins.smear-cursor = {
      enable = true;
      settings = {
        cursor_color = "#ea6962";
        particles_enabled = true;
        particle_max_num = 350;
        stiffness = 0.5;
        trailing_stiffness = 0.2;
        trailing_exponent = 5;
        damping = 0.60;

        distance_stop_animating = 0.5;

        legacy_computing_symbols_support = true;
        hide_target_hack = false;
      };
    };
  };
}

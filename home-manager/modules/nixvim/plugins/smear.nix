{
  programs.nixvim = {
    plugins.smear-cursor = {
      enable = true;
      settings = {
        cursor_color = "#fbf1c7";
        particles_enabled = true;
        particle_max_num = 100;
        particle_spread = 1;
        particles_per_second = 300;
        particles_per_length = 30;
        particle_max_lifetime = 300;
        particle_max_initial_velocity = 15;
        particle_velocity_from_cursor = 0.5;
        particle_damping = 0.15;
        particle_gravity = -50;

        stiffness = 0.8;
        trailing_stiffness = 0.8;
        trailing_exponent = 6;
        damping = 0.60;
        matrix_pixel_threshold = 0.5;

        never_draw_over_target = true;
        hide_target_hack = true;

        distance_stop_animating = 0.5;
        legacy_computing_symbols_support = true;
      };
    };
  };
}

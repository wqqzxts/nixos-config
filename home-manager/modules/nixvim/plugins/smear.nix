{
  programs.nixvim = {
    plugins.smear-cursor = {
      enable = true;
      settings = {
        stiffness = 0.8;
        trailing_stiffness = 0.75;
        trailing_exponent = 12;
        damping = 0.85;

        distance_stop_animating = 0.5;

        legacy_computing_symbols_support = true;
        hide_target_hack = false;
      };
    };
  };
}

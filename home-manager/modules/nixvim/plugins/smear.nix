{
  programs.nixvim = {
    plugins.smear-cursor = {
      enable = true;
      settings = {
        legacy_computing_symbols_support = true;
        distance_stop_animating = 0.5;
        hide_target_hack = false;
        stiffness = 0.8;
        trailing_stiffness = 0.5;
        trailing_exponent = 10;
      };
    };
  };
}

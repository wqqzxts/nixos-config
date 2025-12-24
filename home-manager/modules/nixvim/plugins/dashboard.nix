{
  programs.nixvim.plugins.dashboard = {
    enable = true;
    settings = {
      theme = "hyper";
      config = {
        week_header = {
          enable = true;
        };
      };
    };
  };
}

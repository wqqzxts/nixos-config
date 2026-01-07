{ pkgs, ... }: {
  programs.yazi = {
    enable = true;
    theme = {
      mgr = {
        border_symbol = "│";
        border_style = { type = "plain"; };
      };
      indicator = {
        padding = { open = "█"; close = "█"; };
      };
      confirm = {
        border = { type = "plain"; };
      };
      spot = {
        border = { type = "plain"; };
      };
      pick = {
        border = { type = "plain"; };
      };
      input = {
        border = { type = "plain"; };
      };
      cmp = {
        border = { type = "plain"; };
      };
      tasks = {
        border = { type = "plain"; };
      };
    };
    keymap = {
      mgr.prepend_keymap = [
        { run = "plugin chmod"; on = [ "c" "m" ]; }
      ];
    };
    settings = {
      plugin.prepend_fetchers = [
        {
          id  = "git";
          url = "*";
          run = "git";
        }
        {
          id  = "git";
          url = "*/";
          run = "git";
        }
      ];
    };
    plugins = {
      full-border = pkgs.yaziPlugins.full-border;
      no-status = pkgs.yaziPlugins.no-status;
      git = pkgs.yaziPlugins.git;
      chmod = pkgs.yaziPlugins.chmod;
    };
    initLua = ''
      require("full-border"):setup {
        type = ui.Border.PLAIN,
      }
      require("no-status"):setup()
      require("git"):setup()
    '';
  };
}

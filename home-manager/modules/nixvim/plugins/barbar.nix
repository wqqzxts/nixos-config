{
  programs.nixvim.plugins.barbar = {
    enable = true;
    settings = {
      animation = false;
    };
    keymaps = {
      next.key = "<TAB>";
      previous.key = "<S-TAB>";
      close.key = "<C-q>";
    };
  };
}

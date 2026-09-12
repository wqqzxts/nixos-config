{
  programs.nixvim.plugins.indent-blankline = {
    enable = true;
    settings = {
      indent.char = "│";
      scope = {
        enabled = false;
      };
      exclude = {
        buftypes = [
          "nofile"
          "terminal"
          "quickfix"
          "prompt"
        ];
        filetypes = [
          ""
          "alpha"
          "checkhealth"
          "dashboard"
          "floaterm"
          "help"
          "lazy"
          "lazyterm"
          "lspinfo"
          "mason"
          "neo-tree"
          "notify"
          "NvimTree"
          "nvim-tree"
          "starter"
          "TelescopePrompt"
          "toggleterm"
          "trouble"
          "Trouble"
        ];
      };
    };
  };
}

{
  programs.nixvim = {
    enable = true;

    opts = {
      shiftwidth = 4;

      cursorline = true;
      number = true;
      relativenumber = true;
    };

    plugins.lualine.enable = true;

    plugins.neo-tree.enable = true;

    plugins.telescope.enable = true;

    plugins.treesitter = {
      enable = true;
      highlight.enable = true;
      indent.enable = true;
      folding.enable = true;
    };

    plugins.lspconfig.enable = true;

    plugins.tiny-inline-diagnostic.enable = true;

    plugins.conform-nvim.enable = true;

    plugins.blink-cmp.enable = true;

    plugins.barbar.enable = true;

    plugins.smart-splits.enable = true;

    plugins.toggleterm.enable = true;

    colorschemes.gruvbox.enable = true;
    plugins.web-devicons.enable = true;
  };
}

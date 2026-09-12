{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;

      nixvimInjections = true;

      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
      folding.enable = false;
    };

    treesitter-context.enable = false;

    hmts.enable = false;
  };
}

{ pkgs, ... }: {
  programs.nixvim = {
   globals = {
      loaded_ruby_provider = 0;
      loaded_perl_provider = 0;
      loaded_python_provider = 0;

      vim_json_syntax_conceal = 0;
      vim_json_conceal = 0;
    };

    clipboard = {
      register = "unnamedplus";

      providers.wl-copy.enable = pkgs.stdenv.hostPlatform.isLinux;
    };

    opts = {
      updatetime = 100;
      showmode = false;
      timeoutlen = 300;

      relativenumber = true;
      number = true;
      hidden = true;
      mouse = "a";
      mousemodel = "extend";
      splitbelow = true;
      splitright = true;

      swapfile = false;
      modeline = true;
      modelines = 100;
      undofile = true;
      incsearch = true;
      inccommand = "split";
      ignorecase = true;
      smartcase = true;
      scrolloff = 8;
      cursorline = true;
      cursorcolumn = false;
      signcolumn = "yes";
      colorcolumn = "100";
      laststatus = 3;
      fileencoding = "utf-8";
      termguicolors = true;
      spell = false;
      wrap = false;

      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      autoindent = true;

      textwidth = 0;

      conceallevel = 2;
      concealcursor = "nc";

      foldlevel = 99;
    };
  };
}

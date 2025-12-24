{
  programs.nixvim.autoCmd = [
    # Vertically center document when entering insert mode
    {
      event = "InsertEnter";
      command = "norm zz";
    }

    # Open help in a vertical split
    {
      event = "FileType";
      pattern = "help";
      command = "wincmd L";
    }

    # Enable spellcheck for some filetypes
    {
      event = "FileType";
      pattern = [
        "markdown"
        "typst"
      ];
      command = "setlocal spell spelllang=en";
    }

    # Trailing whitespace highlights
    {
      event = "FileType";
      pattern = "dashboard";
      callback.__raw = ''
        function()
          vim.fn.clearmatches()
          vim.b.whitespace_disable = true
        end
      '';
    }
  ];
}

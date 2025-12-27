{
  programs.nixvim.autoCmd = [
    # vertically center document when entering insert mode
    {
      event = "InsertEnter";
      command = "norm zz";
    }

    # open help in a vertical split
    {
      event = "FileType";
      pattern = "help";
      command = "wincmd L";
    }

    # enable spellcheck for some filetypes
    {
      event = "FileType";
      pattern = [
        "markdown"
        "typst"
      ];
      command = "setlocal spell spelllang=en";
    }
  ];
}

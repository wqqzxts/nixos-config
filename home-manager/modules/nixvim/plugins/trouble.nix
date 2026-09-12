{
  programs.nixvim = {
    plugins.trouble = {
      enable = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>cs";
        action = "<cmd>Trouble symbols toggle focus=true<cr>";
        options = {
          silent = true;
          desc = "Symbols (Trouble)";
        };
      }
    ];
  };
}

{ config, lib, ... }: {
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps =
      let
        normal =
          lib.mapAttrsToList
            (key: action: {
              mode = "n";
              inherit action key;
            })
            {
              "<Space>" = "<NOP>";

              "<esc>" = ":noh<CR>";

              Y = "y$";

              "<C-TAB>" = ":b#<CR>";

              "<C-x>" = ":close<CR>";

              "<C-s>" = ":w<CR>";

              "<leader>h" = "<C-w>h";
              "<leader>l" = "<C-w>l";
              "<leader>j" = "<C-w>j";
              "<leader>k" = "<C-w>k";

              L = "$";
              H = "^";

              "<C-k>" = ":resize -2<CR>";
              "<C-j>" = ":resize +2<CR>";
              "<C-h>" = ":vertical resize +2<CR>";
              "<C-l>" = ":vertical resize -2<CR>";

              "<leader>dt" = ":lua if vim.wo.diff then vim.cmd('diffoff!') else local cur = vim.api.nvim_get_current_win(); vim.cmd('windo diffthis'); vim.api.nvim_set_current_win(cur) end<CR>";
            };
        visual =
          lib.mapAttrsToList
            (key: action: {
              mode = "v";
              inherit action key;
            })
            {
              ">" = ">gv";
              "<" = "<gv";
              "<TAB>" = ">gv";
              "<S-TAB>" = "<gv";

              "K" = ":m '<-2<CR>gv=gv";
              "J" = ":m '>+1<CR>gv=gv";

              L = "$";
              H = "^";

              "<leader>s" = ":sort<CR>";
            };
      in
        config.lib.nixvim.keymaps.mkKeymaps { options.silent = true; } (normal ++ visual);
  };
}

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

              # esc to clear search results
              "<esc>" = ":noh<CR>";

              # fix Y behaviour
              Y = "y$";

              # back and fourth between the two most recent files
              "<M-TAB>" = ":b#<CR>";

              # close by Ctrl+x
              "<C-x>" = ":close<CR>";

              # save by Ctrl+s
              "<C-s>" = ":w<CR>";

              # navigate to left/right window
              "<leader>h" = "<C-w>h";
              "<leader>l" = "<C-w>l";
              "<leader>j" = "<C-w>j";
              "<leader>k" = "<C-w>k";

              # press 'H', 'L' to jump to start/end of a line (first/last character)
              L = "$";
              H = "^";

              # resize with
              "<C-k>" = ":resize -2<CR>";
              "<C-j>" = ":resize +2<CR>";
              "<C-h>" = ":vertical resize +2<CR>";
              "<C-l>" = ":vertical resize -2<CR>";
            };
        visual =
          lib.mapAttrsToList
            (key: action: {
              mode = "v";
              inherit action key;
            })
            {
              # better indenting
              ">" = ">gv";
              "<" = "<gv";
              "<TAB>" = ">gv";
              "<S-TAB>" = "<gv";

              # move selected line / block of text in visual mode
              "K" = ":m '<-2<CR>gv=gv";
              "J" = ":m '>+1<CR>gv=gv";

              # press 'H', 'L' to jump to start/end of a line (first/last character)
              L = "$";
              H = "^";

              # sort
              "<leader>s" = ":sort<CR>";
            };
      in
      config.lib.nixvim.keymaps.mkKeymaps { options.silent = true; } (normal ++ visual);
  };
}

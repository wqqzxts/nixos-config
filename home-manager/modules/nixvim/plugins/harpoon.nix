{ lib, ... }:
{
  programs.nixvim = {
    plugins.harpoon.enable = true;

    keymaps =
      lib.mapAttrsToList
        (key: action: {
          mode = "n";
          inherit key;
          action.__raw = action;
          options.silent = true;
        })
        {
          # add current file
          "<leader>a" = "function() require'harpoon':list():add() end";

          # open menu
          "<S-f>" = "function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list()) end";

          # navigation
          "<leader>1" = "function() require'harpoon':list():select(1) end";
          "<leader>2" = "function() require'harpoon':list():select(2) end";
          "<leader>3" = "function() require'harpoon':list():select(3) end";
          "<leader>4" = "function() require'harpoon':list():select(4) end";
        };
  };
}

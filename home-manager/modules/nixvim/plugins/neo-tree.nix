{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>n";
        action = ":Neotree action=focus reveal toggle<CR>";
        options.silent = true;
      }
    ];

    # i moved to nvim-tree, but kept the neo-tree config in case you'd like to use neo ^^
    plugins.neo-tree = {
      enable = true;

      settings = {
        close_if_last_window = true;
        window = {
          auto_expand_width = true;
          position = "right";
          width = 30;
          mappings = {
            "h" = "close_node";
            "l" = "open";
          };
        };
        filesystem = {
          filtered_items.hide_by_pattern = [
            "*.pdf"
          ];
        };
      };
    };
  };
}

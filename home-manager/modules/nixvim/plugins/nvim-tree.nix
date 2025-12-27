{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>n";
        action = "<cmd>NvimTreeFindFileToggle<CR>";
        options.silent = true;
      }
    ];

    plugins.nvim-tree = {
      enable = true;

      settings = {
        view = {
          side = "right";
          width = 30;
        };
        on_attach = {
          __raw = ''
            function(bufnr)
              local api = require('nvim-tree.api')
              local function opts(desc)
                return {
                  desc = 'nvim-tree: ' .. desc,
                  buffer = bufnr,
                  noremap = true,
                  silent = true,
                  nowait = true
                }
              end
              api.config.mappings.default_on_attach(bufnr)

              vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
              vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
            end
          '';
        };
        filters = {
          custom = [ "\\.pdf$" ];
        };
      };
    };
  };
}

{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      quicker-nvim
    ];

    extraConfigLua = ''
      require("quicker").setup({
        keys = {
          {
            ">",
            function()
              require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
            end,
            desc = "Expand quickfix context",
          },
          {
            "<",
            function()
              require("quicker").collapse()
            end,
            desc = "Collapse quickfix context",
          },
        },
      })
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>q";
        action.__raw = ''
          function()
            require("quicker").toggle()
          end
        '';
        options = {
          silent = true;
          desc = "Toggle Quickfix";
        };
      }
      {
        mode = "n";
        key = "<leader>ql";
        action.__raw = ''
          function()
            require("quicker").toggle({ loclist = true })
          end
        '';
        options = {
          silent = true;
          desc = "Toggle Location List";
        };
      }
    ];
  };
}

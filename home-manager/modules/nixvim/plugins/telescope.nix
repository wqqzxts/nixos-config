{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;

      keymaps = {
        "<leader>tf" = "find_files";
        "<leader>tg" = "live_grep";
        "<leader>tb" = "buffers";
        "<leader>th" = "help_tags";
        "<leader>td" = "diagnostics";
      };

      settings.defaults = {
        file_ignore_patterns = [
          "^.git/"
          "^.mypy_cache/"
          "^__pycache__/"
          "^output/"
          "^data/"
          "%.ipynb"
          "%.pdf"
        ];
        set_env.COLORTERM = "truecolor";
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>tt";
        action.__raw = ''
          function()
            require('telescope.builtin').live_grep({
              default_text="TODO",
              initial_mode="normal"
            })
          end
        '';
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>tG";
        action.__raw = ''
          function()
            vim.ui.input({ prompt = "Grep in dir: ", completion = "dir" }, function(dir)
              if dir and dir ~= "" then
                local target = vim.fn.expand(dir)
                require('telescope.builtin').live_grep({
                  search_dirs = { target },
                  prompt_title = "Live Grep (" .. dir .. ")"
                })
              end
            end)
          end
        '';
        options = {
          silent = true;
          desc = "Live grep in directory";
        };
      }
      {
        mode = "n";
        key = "<leader>tF";
        action.__raw = ''
          function()
            vim.ui.input({ prompt = "Find files in dir: ", completion = "dir" }, function(dir)
              if dir and dir ~= "" then
                local target = vim.fn.expand(dir)
                require('telescope.builtin').find_files({
                  search_dirs = { target },
                  prompt_title = "Find Files (" .. dir .. ")"
                })
              end
            end)
          end
        '';
        options = {
          silent = true;
          desc = "Find files in directory";
        };
      }
    ];
  };
}

{ pkgs, lib, ... }:
let
  neorg-pkg = pkgs.vimPlugins.neorg.overrideAttrs (old: {
    dependencies = [ ];
    passthru = (old.passthru or { }) // { dependencies = [ ]; };
    doCheck = false;
    doInstallCheck = false;
  });
  neorg-telescope-pkg = pkgs.vimPlugins.neorg-telescope.overrideAttrs (old: {
    dependencies = [ ];
    passthru = (old.passthru or { }) // { dependencies = [ ]; };
    doCheck = false;
    doInstallCheck = false;
    postPatch = (old.postPatch or "") + ''
      substituteInPlace lua/telescope/_extensions/neorg/search_headings.lua \
        --replace-warn "filetype = ts_parsers.ft_to_lang(filetype)" \
                       "filetype = (ts_parsers.ft_to_lang and ts_parsers.ft_to_lang(filetype)) or vim.treesitter.language.get_lang(filetype) or filetype" \
        --replace-warn 'ts_configs.is_enabled("highlight", filetype, opts.bufnr)' \
                       '(not ts_configs.is_enabled or ts_configs.is_enabled("highlight", filetype, opts.bufnr))'
    '';
  });
in
{
  programs.nixvim = {
    plugins.neorg = {
      enable = true;
      package = neorg-pkg;
      telescopeIntegration = {
        enable = true;
        package = neorg-telescope-pkg;
      };

      settings = {
        load = {
          "core.defaults" = {
            __empty = { };
          };

          "core.keybinds" = {
            config = {
              default_keybinds = false;
            };
          };

          "core.concealer" = {
            config = {
              icon_preset = "diamond";
              folds = false;
              init_open_folds = "always";
            };
          };

          "core.dirman" = {
            config = {
              workspaces = {
                inbox = "~/personal/neorg/inbox";
                tasks = "~/personal/neorg/tasks";
                projects = "~/personal/neorg/projects";
                knowledge = "~/personal/neorg/knowledge";
              };
              default_workspace = "tasks";
              index = "index.norg";
            };
          };

          "core.journal" = {
            config = {
              strategy = "flat";
              workspace = "tasks";
              journal_folder = "journal";
            };
          };

          "core.completion" = {
            config = {
              engine = "nvim-cmp";
              name = "[neorg]";
            };
          };

          "core.export" = {
            __empty = { };
          };

          "core.export.markdown" = {
            __empty = { };
          };

          "core.summary" = {
            __empty = { };
          };

          "core.qol.toc" = {
            __empty = { };
          };

          "core.qol.todo_items" = {
            __empty = { };
          };

          "core.esupports.hop" = {
            __empty = { };
          };
        };
      };
    };

    files."ftplugin/norg.lua".keymaps = [
      {
        mode = "n";
        key = "<CR>";
        action = "<Plug>(neorg.esupports.hop.hop-link)";
        options = {
          desc = "Neorg: Jump to Link";
          silent = true;
          buffer = true;
        };
      }
      {
        mode = "n";
        key = "gd";
        action = "<Plug>(neorg.esupports.hop.hop-link)";
        options = {
          desc = "Neorg: Jump to Link";
          silent = true;
          buffer = true;
        };
      }
      {
        mode = "n";
        key = "<C-CR>";
        action = "<Plug>(neorg.esupports.hop.hop-link.vsplit)";
        options = {
          desc = "Neorg: Jump to Link (vsplit)";
          silent = true;
          buffer = true;
        };
      }
    ];

    keymaps = [
      {
        mode = "n";
        key = "<leader>nw";
        action = "<cmd>Telescope neorg switch_workspace<CR>";
        options = {
          desc = "Neorg: Switch Workspace";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ni";
        action = "<cmd>Neorg index<CR>";
        options = {
          desc = "Neorg: Open Workspace Index";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>nj";
        action = "<cmd>Neorg journal today<CR>";
        options = {
          desc = "Neorg: Open Today's Journal";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>nn";
        action = "<cmd>Neorg journal toc open<CR>";
        options = {
          desc = "Neorg: Journal Table of Contents";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>nf";
        action = "<cmd>Telescope neorg find_norg_files<CR>";
        options = {
          desc = "Neorg: Find Notes in Workspace";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ng";
        action.__raw = ''
          function()
            local dirman = require("neorg").modules.get_module("core.dirman")
            local ws = dirman and dirman.get_current_workspace()
            local search_dir = ws and tostring(ws[2]) or vim.fn.expand("~/Neorg")
            local ws_name = ws and ws[1] or "all"
            require("telescope.builtin").live_grep({
              prompt_title = "Grep Notes (" .. ws_name .. ")",
              cwd = search_dir,
            })
          end
        '';
        options = {
          desc = "Neorg: Live Grep Notes in Workspace";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>nl";
        action = "<cmd>Telescope neorg insert_link<CR>";
        options = {
          desc = "Neorg: Insert Link via Telescope";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>nt";
        action = "<Plug>(neorg.qol.todo-items.todo.task-cycle)";
        options = {
          desc = "Neorg: Cycle Task State";
          silent = true;
        };
      }
    ];
  };
}

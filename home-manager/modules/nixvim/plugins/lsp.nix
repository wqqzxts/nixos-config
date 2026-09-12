{ lib, ... }:
{
  programs.nixvim = {
    diagnostic.settings.virtual_text = true;

    lsp = {
      inlayHints.enable = true;
      servers = {
        bashls.enable = true;
        docker_compose_language_service.enable = true;
        dockerls.enable = true;
        helm_ls.enable = true;
        nginx_language_server.enable = true;
        nixd.enable = true;
        pyright.enable = true;
        sqls.enable = true;
        terraformls.enable = true;
        yamlls.enable = true;
        lua_ls = {
          enable = true;
          config.settings.diagnostics.globals = [ "vim" ];
        };
      };

      keymaps =
        lib.mapAttrsToList
          (
            key: props:
            {
              inherit key;
              options.silent = true;
            }
            // props
          )
          {
            "<leader>kd".action.__raw = "function() vim.diagnostic.jump({ count=-1, float=true }) end";
            "<leader>jd".action.__raw = "function() vim.diagnostic.jump({ count=1, float=true }) end";
            gd.lspBufAction = "definition";
            gD.lspBufAction = "references";
            gt.lspBufAction = "type_definition";
            gi.lspBufAction = "implementation";
            K.lspBufAction = "hover";
            "<F2>".lspBufAction = "rename";
          };
    };

    plugins = {
      lsp-format = {
        enable = true;
        lspServersToEnable = "all";
      };

      lspconfig.enable = true;
    };
  };
}

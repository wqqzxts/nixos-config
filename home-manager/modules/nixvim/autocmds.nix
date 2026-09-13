{
  programs.nixvim.autoCmd = [
    {
      event = "InsertEnter";
      command = "norm zz";
    }

    {
      event = "FileType";
      pattern = "help";
      command = "wincmd L";
    }

    {
      event = "FileType";
      pattern = [
        "markdown"
        "typst"
      ];
      command = "setlocal spell spelllang=en";
    }

    {
      event = "FileType";
      pattern = [
        "json"
        "jsonc"
        "json5"
      ];
      command = "setlocal conceallevel=0";
    }

    {
      event = [ "BufRead" "BufNewFile" ];
      pattern = [ "*.yaml" "*.yml" "*.tpl" ];
      callback.__raw = ''
        function(args)
          local path = vim.api.nvim_buf_get_name(args.buf)
          if path:match("/templates/.*%.ya?ml$")
             or path:match("/templates/.*%.tpl$")
             or path:match("helmfile.*%.ya?ml$") then
            vim.bo[args.buf].filetype = "helm"
            return
          end

          local lines = vim.api.nvim_buf_get_lines(args.buf, 0, 100, false)
          for _, line in ipairs(lines) do
            if line:match("{{") or line:match("goTemplate:%s*true") then
              vim.bo[args.buf].filetype = "helm"
              break
            end
          end
        end
      '';
    }
  ];
}

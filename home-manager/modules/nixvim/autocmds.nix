{
  programs.nixvim.autoCmd = [
    # vertically center document when entering insert mode
    {
      event = "InsertEnter";
      command = "norm zz";
    }

    # open help in a vertical split
    {
      event = "FileType";
      pattern = "help";
      command = "wincmd L";
    }

    # enable spellcheck for some filetypes
    {
      event = "FileType";
      pattern = [
        "markdown"
        "typst"
      ];
      command = "setlocal spell spelllang=en";
    }

    # disable concealing in JSON files so quotes remain visible
    {
      event = "FileType";
      pattern = [
        "json"
        "jsonc"
        "json5"
      ];
      command = "setlocal conceallevel=0";
    }

    # auto-detect helm / go-template yaml files and switch filetype to helm
    {
      event = [ "BufRead" "BufNewFile" ];
      pattern = [ "*.yaml" "*.yml" "*.tpl" ];
      callback.__raw = ''
        function(args)
          -- Match standard Helm/Helmfile path patterns
          local path = vim.api.nvim_buf_get_name(args.buf)
          if path:match("/templates/.*%.ya?ml$")
             or path:match("/templates/.*%.tpl$")
             or path:match("helmfile.*%.ya?ml$") then
            vim.bo[args.buf].filetype = "helm"
            return
          end

          -- Inspect first 100 lines for Go template syntax or ArgoCD templating
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

{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          timeout_ms = 500;
          lsp_fallback = true;
        };
        formatters_by_ft = {
          nix = [ "alejandra" "nixpkgs_fmt" ];
          python = [ "ruff_format" "black" ];
          yaml = [ "prettier" ];
          json = [ "prettier" ];
          markdown = [ "prettier" ];
          sh = [ "shfmt" ];
          "_" = [ "trim_whitespace" ];
        };
      };
    };

    keymaps = [
      {
        mode = [ "n" "v" ];
        key = "<leader>cf";
        action.__raw = ''
          function()
            require("conform").format({ async = true, lsp_fallback = true })
          end
        '';
        options = {
          silent = true;
          desc = "Format buffer";
        };
      }
    ];
  };
}

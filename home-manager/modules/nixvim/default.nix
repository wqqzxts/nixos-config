{ inputs, nixpkgs, ... }: {
  imports = [
    ./autocmds.nix
    ./completion.nix
    ./keymap.nix
    ./options.nix
    ./perfomance.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    nixpkgs = {
      source = inputs.nixpkgs;
      useGlobalPackages = true;
    };

    colorschemes.base16.settings.telescope_borders = true;

    extraConfigLua = ''
      function ThemeReload()
        local path = vim.env.QS_THEME_FILE or vim.fn.expand("~/.config/quickshell/theme.json")
        local f = io.open(path, "r")
        if not f then return end
        local ok, t = pcall(vim.json.decode, f:read("*a"))
        f:close()
        if not ok or type(t) ~= "table" or type(t.colors) ~= "table" then return end
        vim.o.background = t.polarity == "light" and "light" or "dark"
        require("base16-colorscheme").setup(t.colors)
        vim.api.nvim_exec_autocmds("ColorScheme", {})
        pcall(function() require("lualine").setup(require("lualine").get_config()) end)
      end
    '';

    plugins = {
      lz-n.enable = false;

      web-devicons.enable = true;

      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "+";
          change.text = "~";
        };
      };

      nvim-autopairs.enable = true;

      colorizer = {
        enable = true;
        settings.user_default_options.names = false;
      };

      trim = {
        enable = true;
        settings = {
          ft_blocklist = [
            "TelescopePrompt"
            "checkhealth"
            "dashboard"
            "floaterm"
            "lspinfo"
            "neo-tree"
            "nvim-tree"
          ];
        };
      };
    };
  };
}

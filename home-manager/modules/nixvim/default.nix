{ inputs, ... }: {
  imports = [
    ./autocmds.nix
    ./completion.nix
    ./keymap.nix
    ./keymap.nix
    ./options.nix
    ./perfomance.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;

    colorschemes.gruvbox.enable = true;

    plugins = {
      # Lazy loading
      lz-n.enable = true;

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
          ];
        };
      };
    };
  };
}

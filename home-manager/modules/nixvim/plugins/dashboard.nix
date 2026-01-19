{ lib, ... }: {
  programs.nixvim.plugins.dashboard = {
    enable = true;
    settings = {
      theme = "doom";
      config = {
        header = lib.splitString "\n"
        ''


           ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓
           ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒
          ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░
          ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██
          ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒
          ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░
          ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░
             ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░
                   ░    ░  ░    ░ ░        ░   ░         ░
                                          ░
        '';

        center = [
          {
            icon = "󰈞";
            desc = "  Find File";
            action = "Telescope find_files";
            key = "f";
          }
          {
            icon = "󰺮";
            desc = "  Find Text";
            action = "Telescope live_grep";
            key = "g";
          }
          {
            icon = "󱟱";
            desc = "  Recent Files";
            action = "Telescope oldfiles";
            key = "r";
          }
        ];

        footer = [
          " Managed by NixVim"
        ];
      };
    };
  };
}

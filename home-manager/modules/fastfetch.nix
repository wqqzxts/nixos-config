{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos_small";
        padding = {
          right = 1;
        };
      };
      display = {
        size = {
          binaryPrefix = "si";
        };
        color = "blue";
        separator = " → ";
      };
      modules = [
        "title"
        "separator"
        "os"
        "host"
        "shell"
        {
          type = "command";
          key = "Init System";
          text = "systemctl --version | head -n1";
        }
        "terminal"
        "cpu"
        # "gpu"
        "memory"
        "separator"
        "colors"
      ];
    };
  };
}

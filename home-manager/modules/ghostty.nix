{ lib, ... }: {
  programs.ghostty = {
    enable = true;
    settings = {
      font-style = "Bold";
    };
  };
}

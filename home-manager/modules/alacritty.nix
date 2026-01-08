{ lib, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        builtin_box_drawing = true;
        normal = {
          style = lib.mkForce "Bold";
        };
      };
    };
  };
}

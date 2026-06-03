{
  programs.eww = {
    enable = true;
    # configDir = ./.;
    yuckConfig = builtins.readFile ./eww.yuck;
    scssConfig = builtins.readFile ./eww.scss;
  };
}

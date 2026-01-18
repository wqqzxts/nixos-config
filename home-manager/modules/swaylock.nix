{ pkgs, ... }: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      ignore-empty-password = true;
      indicator = false;
      indicator-radius = 200;
      screenshot = true;
      font = "IosevkaTerm Nerd Font Propo";
      fade-in = 0.65;
      effect-blur = "20x6";

      text-color = "ddc7a1";

      inside-color = "292828";
      ring-color = "504945";
      line-color = "32302f";

      key-hl-color = "7daea3";
      bs-hl-color = "ea6962";

      text-caps-lock-color = "d8a657";
      text-ver-color = "89b482";
      text-wrong-color = "ea6962";
      text-clear-color = "a9b665";

      inside-ver-color = "292828";
      ring-ver-color = "89b482";
      inside-wrong-color = "292828";
      ring-wrong-color = "ea6962";
      inside-clear-color = "292828";
      ring-clear-color = "a9b665";

      separator-color = "00000000";
    };
  };
}

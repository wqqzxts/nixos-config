{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.sandbox = "relaxed";
  nix.settings.trusted-users = [ "root" "wq" ];
}

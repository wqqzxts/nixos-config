{ pkgs, user, ... }: {
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  users.users.${user}.extraGroups = [ "wireshark" ];

  environment.systemPackages = [ pkgs.termshark ];
}

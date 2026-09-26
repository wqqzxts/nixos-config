{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gdb
    iotop-c
    psmisc
    sysstat
  ];
}

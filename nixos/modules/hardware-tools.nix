{ pkgs, ... }: {
  services.fwupd.enable = true;

  environment.systemPackages = with pkgs; [
    dmidecode
    efibootmgr
    hwinfo
    lm_sensors
    nvme-cli
    pciutils
    powertop
    smartmontools
    usbutils
  ];
}

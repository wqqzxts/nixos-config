{ user, ... }: {
  programs.virt-manager.enable = true;

  virtualisation.libvirtd.enable = true;
  users.groups.libvirtd.members = [ "${user}" ];
  virtualisation.spiceUSBRedirection.enable = true;
}

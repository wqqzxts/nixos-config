{
  services.flatpak = {
    enable = true;
    remotes = [
      {
        name = "flathub-beta";
        location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
      }
    ];
    packages = [
      "org.vinegarhq.Sober" # uncomment this if you need roblox xD
    ];
    # overrides = {
    # };
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };
}

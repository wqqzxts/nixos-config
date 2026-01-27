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
      # "org.vinegarhq.Sober" # uncomment this if you need roblox xD
    ];
    overrides = {
      # roblox permission for discord access
      # "org.vinegarhq.Sober".Context.filesystems = [
      #   "xdg-run/app/com.discordapp.Discord:create"
      #   "xdg-run/discord-ipc-0"
      # ];
    };
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };
}

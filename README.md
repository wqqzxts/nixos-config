# 🎨 NixOS Configuration using Flakes

[![Linux](https://img.shields.io/badge/Linux-FCC624?logo=linux&logoColor=black)](#)
[![NixOS](https://img.shields.io/badge/NixOS-5277C3?logo=nixos&logoColor=fff)](#)
![Wayland](https://img.shields.io/badge/Wayland-000000?style=for-the-badge&logo=wayland&logoColor=white)
[![Alacritty](https://img.shields.io/badge/Alacritty-F46D01?logo=alacritty&logoColor=fff)](#)
[![Zsh](https://img.shields.io/badge/Zsh-F15A24?logo=zsh&logoColor=fff)](#)
[![tmux](https://img.shields.io/badge/tmux-1BB91F?logo=tmux&logoColor=fff)](#)
[![Neovim](https://img.shields.io/badge/Neovim-57A143?logo=neovim&logoColor=fff)](#)


Welcome to redesigned [Ampersand's](https://www.youtube.com/@ampersand3636) NixOS configuration with unstable channel.

![screenshot](./screenshots/screenshot1.png) soon should be a showcase

## 🖥️ Quick overview

- ❄️ **[Flakes](https://wiki.nixos.org/wiki/Flakes)**: Configured NixOS flakes for maximum reproducibility.
- 🏠 **[Home Manager Integration](https://nix-community.github.io/home-manager/)**: Configured for managing the home environment.
- 🎨 **[Gruvbox Theme](https://github.com/morhetz/gruvbox)**: A perfect blend of vibrant and subtle colors.
- 🚄 **[Alacritty](https://alacritty.org/):** A fast, GPU-accelerated terminal emulator with a Gruvbox theme and JetBrains Mono font.
- 🧇 **[Tmux](https://github.com/tmux/tmux/wiki)**: With convenient configured hotkeys.
- 🌟 **[Zsh](https://wiki.archlinux.org/title/Zsh)**: Efficient shell setup with lots of aliases.
- 📊 **[Waybar](https://github.com/Alexays/Waybar):** A highly customizable Wayland bar with Gruvbox themed modules.
- 📨 **[Swaync](https://github.com/ErikReider/SwayNotificationCenter):** A notification daemon for Wayland, themed with Gruvbox.
- 🔒 **[Hyprlock](https://hyprland.org/docs/ecosystem/hyprlock/):** The native screen locker for Hyprland, showing a blurred background and the current time.
- 📁 **[Ranger](https://github.com/ranger/ranger):** A console file manager with VI key bindings and image previews, themed with gruvbox.
- 📖 **[Zathura](https://pwmt.org/projects/zathura/):** A highly customizable document viewer with VI-like keybindings and a Gruvbox theme.
- 🦇 **[Bat](https://github.com/sharkdp/bat):** A `cat(1)` clone with wings, using the `gruvbox-dark` theme for syntax highlighting.

## 🚀 Installation

To get started with this setup, follow these steps:

1. **Install NixOS**: If you haven't already installed NixOS, follow the [NixOS Installation Guide](https://nixos.org/manual/nixos/stable/#sec-installation) for detailed instructions.
2. **Clone the Repository**:

	```bash
    https://github.com/wqqzxts/nixos-config.git
    cd nixos-config
    ```

3. **Copy one of the hosts configuration to set up your own**:

    ```bash
    cd hosts
    cp -r slim3 <your_hostname>
    cd <your_hostname>
    ```

4. **Put *your* `hardware-configuration.nix` file there**:

    ```bash
    cp /etc/nixos/hardware-configuration.nix ./
    ```

5. **Edit `hosts/<your_hostname>/local-packages.nix` and `nixos/packages.nix` files if needed**:

    ```bash
    vim local-packages.nix
    vim ../../nixos/modules/filename.nix
    ```

6. **Finally, edit the `flake.nix` file**:

    ```diff
    ...
      outputs = { self, nixpkgs, home-manager, ... }@inputs: let
        system = "x86_64-linux";
    --  homeStateVersion = "24.11";
    ++  homeStateVersion = "<your_home_manager_state_version>";
    --  user = "amper";
    ++  user = "<your_username>";
        hosts = [
    --    { hostname = "slim3"; stateVersion = "24.05"; }
    --    { hostname = "330-15ARR"; stateVersion = "24.11"; }
    ++    { hostname = "<your_hostname>"; stateVersion = "<your_state_version>"; }
        ];
    ...
    ```

7. **Rebuilding**:

    ```bash
    cd nixos-config-reborn
    nixos-rebuild switch --flake path:./#<hostname>
    # or nixos-install --flake path:./#<hostname> if you are installing on a fresh system
    home-manager switch --flake path:.
    ```

## 😎 Enjoy!

![screenshot](./screenshots/screenshot2.png) soon should be a showcase

## 🤝 Contributions

Feel free to fork the repository and submit pull requests if you'd like to contribute improvements. Open issues if you encounter any problems with the config or have ideas for new features.

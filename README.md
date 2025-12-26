# 🎨 NixOS Configuration using Flakes

[![Linux](https://img.shields.io/badge/Linux-FCC624?logo=linux&logoColor=black)](#)
[![NixOS](https://img.shields.io/badge/NixOS-5277C3?logo=nixos&logoColor=fff)](#)
[![Hyprland](https://img.shields.io/badge/Hyprland-00add8?style=for-the-badge)](#)
[![Alacritty](https://img.shields.io/badge/Alacritty-F46D01?logo=alacritty&logoColor=fff)](#)
[![Zsh](https://img.shields.io/badge/Zsh-F15A24?logo=zsh&logoColor=fff)](#)
[![tmux](https://img.shields.io/badge/tmux-1BB91F?logo=tmux&logoColor=fff)](#)
[![Neovim](https://img.shields.io/badge/Neovim-57A143?logo=neovim&logoColor=fff)](#)

![showcase1](./gallery/showcase1.png)
Welcome to redesigned by me [Ampersand's](https://www.youtube.com/@ampersand3636) NixOS configuration with unstable channel.

## 🖥️ Quick overview

- ❄️ **[Flakes](https://wiki.nixos.org/wiki/Flakes)**: Configured NixOS flakes for maximum reproducibility.
- 🏠 **[Home Manager Integration](https://nix-community.github.io/home-manager/)**: Configured for managing the home environment.
- 🎨 **[Gruvbox Theme](https://github.com/morhetz/gruvbox)**: A perfect blend of vibrant and subtle colors.
- 💧 **[Hyprland](https://hypr.land)**: Highly customizable tiling Wayland compositor.
- 📊 **[Waybar](https://github.com/Alexays/Waybar):** A highly customizable Wayland bar with Gruvbox themed modules.
- 📨 **[Swaync](https://github.com/ErikReider/SwayNotificationCenter):** A notification daemon for Wayland, themed with Gruvbox.
- 🔒 **[Hyprlock](https://hyprland.org/docs/ecosystem/hyprlock/):** The native screen locker for Hyprland, showing a blurred background and the current time.
- 🚄 **[Alacritty](https://alacritty.org/):** A fast, GPU-accelerated terminal emulator with a Gruvbox theme and monospace nerd font.
- 🌟 **[Zsh](https://wiki.archlinux.org/title/Zsh)**: Efficient shell setup with lots of aliases.
- 🧇 **[Tmux](https://github.com/tmux/tmux/wiki)**: With convenient hotkeys.
- ⌨️ **[Neovim](https://neovim.io)**: Vim-fork focused on extensibility with configured plugins and gruvbox-material theme.
- 📁 **[Ranger](https://github.com/ranger/ranger):** A console file manager with VI key bindings and image previews, themed with gruvbox.
- 🦇 **[Bat](https://github.com/sharkdp/bat):** A `cat(1)` clone with wings, using the `gruvbox-dark` theme for syntax highlighting.
- 📖 **[Zathura](https://pwmt.org/projects/zathura/):** A highly customizable document viewer with VI-like keybindings and a Gruvbox theme.
- 🛑 **[Zapret](https://https://github.com/bol-van/zapret):** Multi platform DPI bypass service.

## 🚀 Installation

To get started with this setup, follow these steps:

1. **Install NixOS**: If you haven't already installed NixOS, follow the [NixOS Installation Guide](https://nixos.org/manual/nixos/stable/#sec-installation) for detailed instructions.
2. **Clone the Repository**:

	```bash
    https://github.com/wqqzxts/nixos-config.git
    cd nixos-config
    ```

3. **Copy the hosts configuration to set up your own**:

    ```bash
    cd hosts
    cp -r 14ec <your_hostname>
    cd <your_hostname>
    ```

4. **Put *your* `hardware-configuration.nix` file there**:

    ```bash
    cp /etc/nixos/hardware-configuration.nix ./
    ```

5. **Edit `nixos/modules/timezone.nix.example`, `home-manager/modules/git.nix.example`**:

    ```diff
    // do not forget to change the name of file (delete .example)
    {
    --  time.timeZone = "Europe/London";
    ++  time.timeZone = "<YourContinent>/<YourCity>";
    }
    ```

    ```diff
    // do not forget to change the name of file (delete .example)
    user = {
    --  name = "John Doe";
    ++  name = "YourName";
    --  email = "johndoe@example.com";
    ++  email = "youremail@example.com";
    };
    ```

6. **(optional for Russians) Edit `nixos/modules/zapret.nix.example` (if you have own strategy) and enable service in `nixos/modules/default.nix`**:
    ```diff
    // do not forget to change the name of zapret file (delete .example)
    imports = [
    --  # ./zapret.nix
    ++  ./zapret.nix
  ];

7. **Edit other `hosts/<your_hostname>/local-packages.nix` and `nixos/modules/` files if needed (if you think of packages bloat)**:

    ```bash
    nano local-packages.nix
    nano ../../nixos/modules/filename.nix
    ```

8. **Finally, edit the `flake.nix` file**:

    ```diff
    ...
      outputs = { self, nixpkgs, home-manager, ... }@inputs: let
        system = "x86_64-linux";
    --  homeStateVersion = "25.11";
    ++  homeStateVersion = "<your_home_manager_state_version>";
    --  user = "wq";
    ++  user = "<your_username>";
        hosts = [
    --    { hostname = "14ec"; stateVersion = "25.11"; }
    ++    { hostname = "<your_hostname>"; stateVersion = "<your_state_version>"; }
        ];
    ...
    ```

9. **Build system**:

    ```bash
    cd nixos-config
    nixos-rebuild switch --flake path:./#<hostname>
    # or nixos-install --flake path:./#<hostname> if you are installing on a fresh system
    home-manager switch --flake path:.
    ```

## 😎 Enjoy!

![showcase2](./gallery/showcase2.png)

## 🤝 Contributions

Feel free to fork the repository and submit pull requests if you'd like to contribute improvements. Open issues if you encounter any problems with the config or have ideas for new features. Special thanks to [Ampersand's](https://www.youtube.com/@ampersand3636) as he provided NixOS config.

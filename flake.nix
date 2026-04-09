{
  description = "NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-flatpak.url = "github:gmodena/nix-flatpak";

    stylix = {
      url = "github:danth/stylix/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprland.follows = "hyprland";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    claude-code.url = "github:sadjow/claude-code-nix";
  };

  outputs = { self, nixpkgs, home-manager, claude-code, ... }@inputs: let
    system = "x86_64-linux";
    homeStateVersion = "26.05";
    user = "wq";
    hosts = [
      { hostname = "14ec"; stateVersion = "26.05"; }
    ];

    makeSystem = { hostname, stateVersion }: nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {
        inherit inputs stateVersion hostname user;
      };

      modules = [
        ./hosts/${hostname}/configuration.nix
        # inputs.nix-flatpak.nixosModules.nix-flatpak
        ./overlays.nix
      ];
    };

  in {
    nixosConfigurations = nixpkgs.lib.foldl' (configs: host:
      configs // {
        "${host.hostname}" = makeSystem {
          inherit (host) hostname stateVersion;
        };
      }) {} hosts;

    homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {
        inherit inputs homeStateVersion user;
      };

      modules = [
        ({ modulesPath, ... }: {
          disabledModules = ["${modulesPath}/programs/anyrun.nix"];
        })
        inputs.stylix.homeModules.stylix
        inputs.niri.homeModules.niri
        inputs.nixvim.homeModules.nixvim
        inputs.spicetify.homeManagerModules.spicetify
        inputs.anyrun.homeManagerModules.anyrun
        ./home-manager/home.nix
        ./overlays.nix
      ];
    };
  };
}

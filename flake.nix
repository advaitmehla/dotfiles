{
  description = "Initial NixOS flake";

  inputs = {
    # Core packages (latest stable and unstable as of March 2025)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # Home Manager for user-specific configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # KDE-related customizations
    darkly = {
      url = "github:Bali10050/Darkly";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    kwin-better-blur = {
      url = "github:taj-ny/kwin-effects-forceblur/window-rules";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    kwin-effects-startupfeedback-busy-cursor = {
      url = "github:taj-ny/kwin-effects-startupfeedback-busy-cursor";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... } @ inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    unstablePkgs = nixpkgs-unstable.legacyPackages.${system};

    # KDE rounded corners overlay
    overlay-kde-rounded = import ./overlays/kde-rounded-corners;
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      
      modules = [
        # Use unstable channel for KDE packages only
        ({ config, pkgs, ... }: {
          nixpkgs.overlays = [
            (final: prev: {
              kdePackages = nixpkgs-unstable.legacyPackages.${prev.system}.kdePackages;
            })
          ];
        })
        ./configuration.nix
      ];

      specialArgs = {
        inherit unstablePkgs inputs;
      };
    };

    homeConfigurations.advait = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit unstablePkgs inputs;
      };
      modules = [ ./home.nix ];
    };
  };

  # Instructions for updating system:
  # 1) nix flake update
  # 2) sudo nixos-rebuild switch --flake .
  # 3) home-manager switch --flake .
  
  # Fix flake.lock permission issue if needed:
  # sudo chown advait flake.lock
  # sudo chgrp users flake.lock
}
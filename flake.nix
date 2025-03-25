{
  description = "Initial flake!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs"; # Ensure consistency with nixpkgs
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... } @ inputs:
  let
    system = "x86_64-linux";
    overlays = import ./overlays.nix;
    pkgs = import nixpkgs {
      inherit system;
    };
    unstablePkgs = nixpkgs-unstable.legacyPackages.${system};
    customPkgs = import ./pkgs/default.nix { 
      inherit pkgs;
      lib = nixpkgs.lib;
    };
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      
      modules = [
        # Use unstable channel for KDE packages only
        # ({ config, pkgs, ... }: {
        #   nixpkgs.overlays = [
        #     (final: prev: {
        #       kdePackages = nixpkgs-unstable.legacyPackages.${prev.system}.kdePackages;
        #     })
        #   ];
        # })
        ./configuration.nix
      ];

      specialArgs = {
        inherit unstablePkgs inputs customPkgs;
      };
    };

    homeConfigurations.advait = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      extraSpecialArgs = {
        inherit unstablePkgs inputs customPkgs;
      };

      modules = [ ./home.nix ];
    };
    packages.${system} = customPkgs;
  };
  # Update system:
  # 1) nix flake update
  # 2) sudo nixos-rebuild switch --flake .
  # 3) home-manager switch --flake .

  # Fix flake.lock permission issues:
  # sudo chown advait flake.lock
  # sudo chgrp users flake.lock
}

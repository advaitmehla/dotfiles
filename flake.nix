{

    description = "Initial flake!";

    inputs = {
        # give url to get packages - latest as of March 2025. Does this have to be updated later?
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/release-24.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs"; # make sure versions are same

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

    outputs = {self, nixpkgs, nixpkgs-unstable, home-manager, kwin-better-blur, darkly, plasma-manager, ...}: 
    let 
        lib = nixpkgs.lib; # done to "pass" lib to outputs - otherwise lib.xyz wont work
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
        overlay-kde-rounded = import ./overlays/kde-rounded-corners;
        unstablePkgs = import nixpkgs-unstable {
            inherit system;
            overlays = [ overlay-kde-rounded ];  # Apply overlay to unstable too
        };
        inputs = { inherit kwin-better-blur darkly plasma-manager; };  # And add plasma-window-title here
    in 
    {
        nixosConfigurations = {
            # give it any name for your config - usually hostname
            nixos = lib.nixosSystem {
                inherit system;
                modules = [ 
                    ({ config, pkgs, ... }: {
                    # Create an overlay that pulls specific packages from unstable
                    nixpkgs.overlays = [
                        (final: prev: {
                        # Use unstable channel just for KDE packages
                        kdePackages = nixpkgs-unstable.legacyPackages.${prev.system}.kdePackages;
                        })
                    ];
                    })
                    ./configuration.nix 
                ];
                specialArgs = { 
                    inputs = { inherit kwin-better-blur darkly; }; 
                    unstablePkgs = nixpkgs-unstable.legacyPackages.x86_64-linux;
                };
            };
        };

        homeConfigurations = {
            # give it any name for your config - usually username
            advait = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = { 
                    inherit inputs unstablePkgs;  # Pass both inputs and unstablePkgs
                };
                modules = [ ./home.nix ];
            };

        };
    };

# to update system 1) nix flake update
#                  2) sudo nixos-rebuild switch --flake .
#                  3) home-manager switch --flake .

# flake.lock permission issue:
# sudo chown advait flake.lock
# sudo chgrp users flake.lock
}
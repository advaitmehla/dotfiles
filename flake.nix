{

    description = "Initial flake!";

    inputs = {
        # give url to get packages - latest as of March 2025. Does this have to be updated later?
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
        home-manager.url = "github:nix-community/home-manager/release-24.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs"; # make sure versions are same
    };

    outputs = {self, nixpkgs, home-manager, ...}: 
    let 
        lib = nixpkgs.lib; # done to "pass" lib to outputs - otherwise lib.xyz wont work
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in 
    {
        nixosConfigurations = {
            # give it any name for your config - usually hostname
            nixos = lib.nixosSystem {
                inherit system;
                modules = [ ./configuration.nix ];
            };
        };

        homeConfigurations = {
            # give it any name for your config - usually username
            advait = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
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
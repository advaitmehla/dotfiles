{ config, pkgs, unstablePkgs, inputs, ... }:

{
  imports = [
    ./sh.nix
    inputs.plasma-manager.homeManagerModules.plasma-manager
    ./plasma/panels.nix
  ];

  home.username = "advait";
  home.homeDirectory = "/home/advait";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    hello
    curl
    kdePackages.kate
    vscode
    # papirus-icon-theme
    # whitesur-kde
    # whitesur-gtk-theme
    # bibata-cursors
    neofetch
    brave
    plasma-panel-colorizer
    plasma-applet-commandoutput
  ];

  home.file = {

  };

  home.sessionVariables = {
    EDITOR = "nano";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # enable git
  programs.git = {
    enable = true;
    userName = "advaitmehla";
    userEmail = "advait.mehla@gmail.com";
    lfs.enable = true;  # If you need Git LFS
    extraConfig = {
        init.defaultBranch = "main";
    };
  };
  
}

# To roll-back to previous configs:
# 1) home-manager generations - lists prev versions, most recent at top
# 2) copy the generation path
# 3) Run "<path>/activate"

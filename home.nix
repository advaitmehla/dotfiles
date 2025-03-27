{ config, pkgs, unstablePkgs, inputs, ... }:

{
  imports = [
    ./sh.nix
    inputs.plasma-manager.homeManagerModules.plasma-manager
    ./plasma/panels.nix
    ./plasma/darkly.nix
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
    papirus-icon-theme
    inputs.darkly.packages.${pkgs.system}.darkly-qt5
    inputs.darkly.packages.${pkgs.system}.darkly-qt6
    bibata-cursors

    neofetch
    brave
    slack
    zoom-us
    
    plasma-panel-colorizer
    plasma-applet-commandoutput
    nix-prefetch-github
  ];

  home.file = {

  };

  home.sessionVariables = {
    EDITOR = "nano";
  };

  programs.home-manager.enable = true;

  programs.plasma.enable = true;
  programs.plasma.workspace = {
    wallpaper = "/home/advait/Pictures/Wallpapers/skip7_cr_rot.jpg";
    iconTheme = "Papirus-Dark";
    theme = "breeze-dark";
    colorScheme = "BreezeDark";
  };

  qt = {
    enable = true;
    style.package = [
      inputs.darkly.packages.${pkgs.system}.darkly-qt5
      inputs.darkly.packages.${pkgs.system}.darkly-qt6
    ];
    platformTheme.name = "kde";
  };



}

# To roll-back to previous configs:
# 1) home-manager generations - lists prev versions, most recent at top
# 2) copy the generation path
# 3) Run "<path>/activate"

{ config, pkgs, unstablePkgs, inputs, ... }:

{
  imports = [
    ./shell/default.nix
    ./plasma/default.nix
    ./autostart.nix
  ];
  
  programs.home-manager.enable = true;
  home.username = "advait";
  home.homeDirectory = "/home/advait";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # utilities
    curl
    tree
    kdePackages.kate
    nix-prefetch-github
    neofetch
    
    # apps
    brave
    slack
    zoom-us
    vscode
    qbittorrent
    vlc
    discord
  ];


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

  home.sessionVariables = {
    EDITOR = "nano";
  };

}

# To roll-back to previous configs:
# 1) home-manager generations - lists prev versions, most recent at top
# 2) copy the generation path
# 3) Run "<path>/activate"

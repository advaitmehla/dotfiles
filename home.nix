{ config, pkgs, unstablePkgs, inputs, ... }:

{
  imports = [
    ./sh.nix
    inputs.plasma-manager.homeManagerModules.plasma-manager
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
#     latte-dock
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

  # programs.plasma = {
  #   enable = true;
  #   workspace = {
  #     theme = "WhiteSur";               # Plasma Style
  #     colorScheme = "WhiteSurDark";     # Color Scheme
  #     lookAndFeel = "com.github.vinceliuice.WhiteSur-dark";         # Global Theme
  #     clickItemTo = "select";           # Click Behavior
  #   };
  # };

  # gtk = {
  #   enable = true;
  #   theme = {
  #     package = pkgs.whitesur-gtk-theme;
  #     name = "WhiteSur-Dark";
  #   };
  #   iconTheme = {
  #     package = pkgs.papirus-icon-theme;
  #     name = "Papirus-Dark";
  #   };
  #   cursorTheme = {
  #     package = pkgs.bibata-cursors;
  #     name = "Bibata-Modern-Classic";
  #   };
  # };

}

# To roll-back to previous configs:
# 1) home-manager generations - lists prev versions, most recent at top
# 2) copy the generation path
# 3) Run "<path>/activate"

{ config, pkgs, unstablePkgs, inputs, ... }:

{
  imports = [
    ./sh.nix
    inputs.plasma-manager.homeManagerModules.plasma-manager
    ./plasma/panels.nix
    # ./plasma/darkly.nix
    ./plasma/shortcuts.nix
  ];

  home.username = "advait";
  home.homeDirectory = "/home/advait";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    hello
    curl
    kdePackages.kate
    kdePackages.networkmanager-qt
    
    papirus-icon-theme
    inputs.darkly.packages.${pkgs.system}.darkly-qt5
    inputs.darkly.packages.${pkgs.system}.darkly-qt6
    bibata-cursors
    # kdePackages.sierra-breeze-enhanced
    # kdePackages.kdecoration

    neofetch
    brave
    slack
    zoom-us
    vscode
    qbittorrent
    vlc
    
    plasma-panel-colorizer
    plasma-applet-commandoutput
    nix-prefetch-github
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

  programs.home-manager.enable = true;

  programs.plasma.enable = true;
  programs.plasma.workspace = {
    wallpaper = "/home/advait/Pictures/Wallpapers/skip7_cr_rot.jpg";
    iconTheme = "Papirus-Dark";
    theme = "breeze-dark";
    colorScheme = "BreezeDark";
    cursor.theme = "Bibata-Modern-Ice";
    # windowDecorations = {
    #   library = "org.kde.kdecoration2";
    #   theme = "SierraBreezeEnhanced";
    #   # titlebarLayout = "MNCX";  # Menu, Minimize, Close, Maximize buttons
    # };
  };

  qt = {
    enable = true;
    style.package = [
      inputs.darkly.packages.${pkgs.system}.darkly-qt5
      inputs.darkly.packages.${pkgs.system}.darkly-qt6
    ];
    # platformTheme.name = "kde";
  };

  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };
    iconTheme = {
      name = "Papirus-Dark";  
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-cursor-theme-name = "Bibata-Modern-Ice";
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-cursor-theme-name = "Bibata-Modern-Ice";
    };
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24; # Adjust the size as needed
    x11.enable = true;
    gtk.enable = true;
  };

  programs.plasma.spectacle.shortcuts.captureRectangularRegion = "Meta+Shift+S";

}

# To roll-back to previous configs:
# 1) home-manager generations - lists prev versions, most recent at top
# 2) copy the generation path
# 3) Run "<path>/activate"

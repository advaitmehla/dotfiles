{ config, pkgs, unstablePkgs, inputs, ... }:

{
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
    ./panels.nix
    ./darkly.nix
    ./shortcuts.nix
    ./power.nix
  ];

  home.packages = with pkgs; [
    # theming
    plasma-panel-colorizer
    plasma-applet-commandoutput
    papirus-icon-theme
    inputs.darkly.packages.${pkgs.system}.darkly-qt5
    inputs.darkly.packages.${pkgs.system}.darkly-qt6
    bibata-cursors
    # kdePackages.sierra-breeze-enhanced
    # kdePackages.kdecoration
  ];

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
    # platformTheme.name = "kde"; # this break system settings
  };

  # commented because no gtk apps - pain in the ass for hm switches
  # gtk = {
  #   enable = true;
  #   theme = {
  #     name = "Breeze-Dark";
  #     package = pkgs.kdePackages.breeze-gtk;
  #   };
  #   iconTheme = {
  #     name = "Papirus-Dark";  
  #     package = pkgs.papirus-icon-theme;
  #   };
  #   cursorTheme = {
  #     name = "Bibata-Modern-Ice";
  #     package = pkgs.bibata-cursors;
  #   };
  #   gtk3.extraConfig = {
  #     gtk-application-prefer-dark-theme = true;
  #     gtk-cursor-theme-name = "Bibata-Modern-Ice";
  #   };
  #   gtk4.extraConfig = {
  #     gtk-application-prefer-dark-theme = true;
  #     gtk-cursor-theme-name = "Bibata-Modern-Ice";
  #   };
  # };

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    x11.enable = true;
    gtk.enable = true;
  };

  programs.plasma.spectacle.shortcuts.captureRectangularRegion = "Meta+Shift+S";

}

# To roll-back to previous configs:
# 1) home-manager generations - lists prev versions, most recent at top
# 2) copy the generation path
# 3) Run "<path>/activate"

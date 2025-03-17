{ config, pkgs, unstablePkgs, inputs, ... }:

{
  imports = [
    ./sh.nix
    inputs.plasma-manager.homeManagerModules.plasma-manager
    ./plasma/panel.nix
    ./plasma/effects.nix
    ./plasma/darkly.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "advait";
  home.homeDirectory = "/home/advait";
  home.enableNixpkgsReleaseCheck = false;
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Add KDE application registration
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = ["dolphin.desktop"];
      "x-scheme-handler/file" = ["dolphin.desktop"];
      "x-scheme-handler/trash" = ["dolphin.desktop"];
    };
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    hello
    curl
    neofetch
    htop
    # brave
    # gfortran
  ] ++ [
    unstablePkgs.plasma-panel-colorizer
    # unstablePkgs.plasma-window-title-applet
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  home.sessionVariables = {
    # EDITOR = "emacs";
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

  # plasma config
  programs.plasma = {
    enable = true;
    # Basic workspace settings
    workspace = {
      theme = "breeze-dark";
      colorScheme = "BreezeDark";
      clickItemTo = "select";
    };
  };

  # Qt/GTK theming
  gtk = {
    enable = true;
    theme = {
      package = unstablePkgs.kdePackages.breeze-gtk;  # Use unstable
      name = "Breeze";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "kde";
    style = {
      name = "darkly";
      package = inputs.darkly.packages.${pkgs.system}.darkly-qt5;  # Use from inputs
    };
  };

}
# To roll-back to previous configs:
# 1) home-manager generations - lists prev versions, most recent at top
# 2) copy the generation path
# 3) Run "<path>/activate"
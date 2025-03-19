{ config, pkgs, unstablePkgs, inputs, ... }:

{
  imports = [
    ./sh.nix
  ];

  home.username = "advait";
  home.homeDirectory = "/home/advait";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    hello
    curl
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {

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

}

# To roll-back to previous configs:
# 1) home-manager generations - lists prev versions, most recent at top
# 2) copy the generation path
# 3) Run "<path>/activate"

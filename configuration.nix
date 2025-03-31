{ config, pkgs, unstablePkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
    };
    grub = {
      enable = true;
      efiSupport = true;
      #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
      device = "nodev";
    };
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

   # Used by KDE to obtain location
  services.geoclue2.enable = true;

  services.power-profiles-daemon.enable = true;


  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.advait = {
    isNormalUser = true;
    description = "Advait Mehla";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # home manager used for this
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # for consistent gtk theming
  programs.dconf.enable = true;

  programs.nix-ld.enable = true;
  environment.systemPackages = with pkgs; [
    nano
    wget
    git
    gcc
    micromamba
    htop
    home-manager
    binutils
    libinput
    bluez-tools
    toybox
    powertop
  ];

  # enable zsh as default
  environment.shells = with pkgs; [zsh bash];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    shellInit = ''
      export MAMBA_ROOT_PREFIX="$HOME/micromamba"
      eval "$(micromamba shell hook --shell zsh)"
      micromamba activate basic
    '';
  };

  services.sonarr = {
    enable = true;
    openFirewall = true;
    user = "advait";
    group = "users";
    dataDir = "/home/advait/local/sonarr";
  };

  services.jackett = {
    enable = true;
    openFirewall = true;
    user = "advait";
    group = "users";
    dataDir = "/home/advait/local/jackett";
  };


  fonts.fontconfig.enable = true;
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      inter
      nerd-fonts.hack
    ];
  };
  fonts.fontconfig.defaultFonts = {
    monospace = [ "Hack Nerd Font" ];
    sansSerif = [ "Inter" ];
    serif = [ "Inter" ];           
  };
  system.stateVersion = "24.11"; # Probably don't change this
  nix.settings.experimental-features = ["nix-command" "flakes"];

  systemd.services."user@".serviceConfig.TimeoutStopSec = "5s"; # Workaround for slow shutdown

}

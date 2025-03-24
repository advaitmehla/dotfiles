{
  lib,
  pkgs,
  customPkgs,
  ...
}:

{
  home.packages = lib.attrValues {
    inherit (pkgs) plasma-applet-commandoutput plasma-panel-colorizer;
    inherit (customPkgs) plasma-window-title-applet panel-system-info;
  };
  programs.plasma.enable = true;
  programs.plasma.panels = [
    # Top panel with system info and controls
    {
      height = 25;
      location = "top";
      floating = false;
      widgets = [
        {
          kickoff.icon = "nix-snowflake"; # Used only for the icon, it's better than media frame
        }
        {
          name = "org.kde.windowtitle";
          config = {
            Appearance = {
              txt = "%i"; # Use icon-only placeholder
              altTxt = ""; # Empty alt text
              txtSameFound = ""; # No duplicate handling
              noIcon = false; # Ensure icons are enabled
              fontSize = 0; # Collapse text space
              fillThickness = true; # Better icon scaling
              lengthKind = 3; # Fixed size policy (3 = Fill)
              fixedLength = 24; # Match icon size
            };
            
            Behavior = {
              showTooltip = false; # Disable hover text
            };

            Substitutions = {
              subsMatchApp = [".*"]; # Regex match all apps
              subsMatchTitle = [".*"]; # Regex match all titles
              subsReplace = [""]; # Replace with empty string
            };
          };
        }
        "org.kde.plasma.appmenu"
        "org.kde.plasma.panelspacer"
        {
          name = "com.github.zren.commandoutput";
          config.General = {
            command = "${customPkgs.panel-system-info}/bin/panel-system-info";
            fontFamily = "Hack";
            fontSize = 10;
            interval = 0;
            waitForCompletion = true;
          };
        }
        {
          systemTray.items = {
            # hidden = [
            #   "Clementine"
            #   "org.kde.kscreen"
            #   "org.kde.kdeconnect"
            #   "org.kde.plasma.brightness"
            #   "org.kde.plasma.cameraindicator"
            #   "org.kde.plasma.clipboard"
            #   "org.kde.plasma.keyboardlayout"
            #   "org.kde.plasma.keyboardindicator"
            #   "org.kde.plasma.manage-inputmethod"
            #   "org.kde.plasma.mediacontroller"
            #   "vmware-tray"
            #   "Yakuake"
            # ];
            shown = [
              "org.kde.plasma.battery"
              "org.kde.plasma.volume"
              "org.kde.plasma.networkmanagement"
            ];
          };
        }
        {
          digitalClock = {
            date.enable = true;
            time.showSeconds = "never";
          };
        }
        {
          name = "luisbocanegra.panel.colorizer";
          config.General = {
            colorMode = "1";
            colorModeTheme = "9";
            enableCustomPadding = "true";
            fgColorMode = "1";
            fgContrastFixEnabled = "false";
            fgLightness = "0.55";
            hideWidget = "true";
            marginRules = "org.kde.plasma.kickoff,1,0|org.kde.windowtitle,1,0|plasmusic-toolbar,0,-15";
            panelPadding = "16";
            panelRealBgOpacity = "0.5";
            panelSpacing = "10";
            radius = "7";
            widgetBgEnabled = "false";
            widgetBgVMargin = "3";
          };
        }
      ];
    }
    
    # Bottom dock-style panel
    {
      location = "bottom";
      height = 52; # As shown in the image
      floating = true;
      alignment = "center";
      hiding = "dodgewindows";
      opacity = "adaptive";
      widgets = [
        {
          iconTasks = {
            launchers = [
              "applications:org.kde.dolphin.desktop"
              "applications:org.kde.konsole.desktop"
              "applications:brave-browser.desktop"
              "applications:code.desktop"

            ];
            # showOnlyCurrentDesktop = false;
            # showOnlyCurrentActivity = false;
            # indicateAudioStreams = true;
          };
        }
      ];
    }
  ];
}

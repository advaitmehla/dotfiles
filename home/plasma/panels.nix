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

  # top panel
  programs.plasma.panels = [
    {
  height = 22;
  location = "top";
  floating = false;
  widgets = [
    {
      kickoff.icon = "nix-snowflake";
    }
    {
      name = "org.kde.windowtitle";
      config = {
        Appearance = {
          txt = "%i";
          altTxt = "";
          txtSameFound = "";
          noIcon = false;
          fontSize = 0;
          fillThickness = true;
          lengthKind = 3;
          fixedLength = 24;
        };
        Behavior = {
          showTooltip = false;
        };
      };
    }
    # {
    #   name = "org.kde.plasma.appmenu";
    # }

    # **Make this panel spacer expandable to push elements apart**
    {
      name = "org.kde.plasma.panelspacer";
      config = {
        General.expanding = true;
      };
    }

    {
      name = "org.kde.plasma.digitalclock";
      config = {
        Appearance = {
          showDate = true;
          use24hFormat = true;
          dateFormat = "custom"; 
          customDateFormat = "MMM d"; # "Mar 25" format
          autoFontAndSize = false;
          fontSize = 10;
          fontFamily = "Inter SemiBold";
        };
      };
    }

    # **Another expandable spacer for centering effect**
    {
      name = "org.kde.plasma.panelspacer";
      config = {
        General.expanding = true;
      };
    }

    {
      name = "com.github.zren.commandoutput";
      config.General = {
        command = "${customPkgs.panel-system-info}/bin/panel-system-info";
        fontFamily = "Hack Nerd Font";
        fontSize = 8;
        interval = 0;
        waitForCompletion = true;
      };
    }

    {
      systemTray.items = {
        hidden = [
          "Clementine"
          "org.kde.kscreen"
          "org.kde.kdeconnect"
          "org.kde.plasma.brightness"
          "org.kde.plasma.cameraindicator"
          "org.kde.plasma.clipboard"
          "org.kde.plasma.keyboardlayout"
          "org.kde.plasma.keyboardindicator"
          "org.kde.plasma.manage-inputmethod"
          "org.kde.plasma.mediacontroller"
          "vmware-tray"
          "Yakuake"
        ];
        shown = [
          "org.kde.plasma.battery"
          "org.kde.plasma.volume"
          "org.kde.plasma.networkmanagement"
        ];
      };
    }

    # # **This spacer pushes everything to the right edge**
    # {
    #   name = "org.kde.plasma.panelspacer";
    #   config = {
    #     General.expanding = false;
    #   };
    # }

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
        panelRealBgOpacity = "0.10";
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
      height = 60; # As shown in the image
      floating = true;
      alignment = "center";
      hiding = "dodgewindows";
      # opacity = "adaptive";
      lengthMode = "fit";
      widgets = [
      {
        name = "org.kde.plasma.icontasks";
        config = {
          General = {
            showToolTips = false; 
            interactiveMute = true;
            tooltipControls = false;
            launchers = [
              "applications:brave-browser.desktop"
              "applications:org.kde.dolphin.desktop"
              "applications:org.kde.konsole.desktop"
              "applications:code.desktop"
            ];
          };
        };
      }
    # {
    #   name = "luisbocanegra.panel.colorizer";
    #   config.General = {
    #     hideWidget = "true";
    #     # globalSettings = ''{"nativePanelBackground": {"enabled": false}}'';        # panelWidgets = builtins.readFile ./widgets.json;
    #   };
    # }

  
      ];
    }
  ];
}

{ pkgs, unstablePkgs, lib, ... }: {
  home.packages = [
    unstablePkgs.plasma-applet-commandoutput
    unstablePkgs.plasma-panel-colorizer
  ];

  programs.plasma.panels = [
    {
      location = "top";
      height = 32;
      widgets = [
        {
          name = "org.kde.windowtitle";
          config = {
            "General" = {
              bold = false;
              showIcon = false;
            };
          };
        }
        "org.kde.plasma.appmenu"
        "org.kde.plasma.panelspacer"
        {
          name = "org.kde.plasma.systemtray";
          config = {
            "General" = {
              extraItems = [
                "org.kde.kscreen"
                "org.kde.kdeconnect"
                "org.kde.plasma.volume"
              ];
            };
          };
        }
      ];
    }
    {
      location = "bottom";
      height = 38;
      widgets = [
        "org.kde.plasma.kickoff"  # Application launcher
        "org.kde.plasma.taskmanager"  # Task manager
        "org.kde.plasma.pager"  # Virtual desktop pager
      ];
    }
  ];
}
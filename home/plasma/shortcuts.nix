{
  lib,
  pkgs,
  ...
}:

let
  shortcuts = {
    "Meta+Ctrl+Shift+L" = "${pkgs.kdePackages.qttools}/bin/qdbus org.kde.Shutdown /Shutdown org.kde.Shutdown.logout";
    "Meta+Ctrl+Shift+H" = "systemctl hibernate";
    "Meta+Ctrl+Shift+P" = "systemctl poweroff";
    "Meta+Ctrl+Shift+R" = "systemctl reboot";
    "Meta+Ctrl+Shift+S" = "systemctl suspend";
    "Ctrl+Shift+Esc" = "plasma-systemmonitor";
    "Meta+T" = "konsole";
    # "Meta+Shift+C" = "clementine";
    # "Meta+Shift+F" = "firefox";
    # "Meta+Shift+Return" = "konsole";
    # "Meta+Shift+T" = "kwrite";
    # "Meta+Shift+V" = "codium";
    # "Meta+Shift+X" = "systemsettings";
    # "Meta+Shift+Z" = "keepassxc";
  };
in
{
  programs.plasma = {
    file.".config/kwinrc" = {
      "Plugins" = {
        "minimizeallEnabled" = {
          value = true;
        };
      };
    };
    hotkeys.commands =
      lib.mapAttrs'
        (name: value:
          lib.nameValuePair
            (lib.replaceStrings [ "+" ] [ "" ] name)
            {
              command = value;
              key = name;
            }
        )
        shortcuts;
    shortcuts = {
      kwin = {
        "Show Desktop" = "none,none,Show Desktop";
        "MinimizeAll" = "Meta+D";
        "Toggle Tiles Editor" = "Alt+T,none,Toggle Tiles Editor";
        "Window Fullscreen" = "Meta+F,none,Window Fullscreen";
      };
      Konsole = {
        "Launch" = "none,none,Launch";
      };
      plasmashell = {
        # "activate application launcher" = "none";
        # "manage activities" = "none";
        # "next activity" = "none";
        # "previous activity" = "none";
        # "stop current activity" = "none";
      };
      # "services/org.kde.dolphin.desktop"."_launch" = "Meta+Shift+E";
      # "services/org.kde.krunner.desktop"."_launch" = "Meta+X";
      # "services/org.kde.spectacle.desktop"."_launch" = "Print";
    };
  };
}
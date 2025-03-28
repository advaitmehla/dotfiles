let 
  autostartPrograms = [ 
    # pkgs.steam
    pkgs.slack
    pkgs.qbittorrent
  ];
in {
  home.file = builtins.listToAttrs (map (pkg: {
    name = ".config/autostart/" + pkg.pname + ".desktop";
    value = if pkg ? desktopItem then {
      text = pkg.desktopItem.text;
    } else {
      source = "${pkg}/share/applications/${pkg.pname}.desktop";
    };
  }) autostartPrograms);
}
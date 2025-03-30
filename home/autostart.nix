{pkgs, ...}:

let 
  autostartPrograms = [ 
    # pkgs.steam
    pkgs.slack
    # Add more apps here
  ];
in {
  home.file = builtins.listToAttrs (map (pkg: {
    name = ".config/autostart/" + pkg.pname + ".desktop";
    value = if pkg ? desktopItem then {
      text = pkg.desktopItem.text;
    } else {
      source = "${pkg}/share/applications/${pkg.pname}.desktop";
    };
  }) autostartPrograms) // {
    # Separate handling for qBittorrent
    ".config/autostart/qbittorrent.desktop" = {
      text = ''
        [Desktop Entry]
        Categories=Network;FileTransfer;P2P;Qt;
        Exec=qbittorrent %U
        GenericName=BitTorrent client
        Comment=Download and share files over BitTorrent
        Icon=qbittorrent
        MimeType=application/x-bittorrent;x-scheme-handler/magnet;
        Name=qBittorrent
        Terminal=false
        Type=Application
        StartupNotify=false
        StartupWMClass=qbittorrent
        Keywords=bittorrent;torrent;magnet;download;p2p;
        SingleMainWindow=true
      '';
    };
  };
}

# {pkgs, ...}:

# let 
#   autostartPrograms = [ 
#     # pkgs.steam
#     pkgs.slack
#     # pkgs.qbittorrent
#   ];
# in {
#   home.file = builtins.listToAttrs (map (pkg: {
#     name = ".config/autostart/" + pkg.pname + ".desktop";
#     value = if pkg ? desktopItem then {
#       text = pkg.desktopItem.text;
#     } else {
#       source = "${pkg}/share/applications/${pkg.pname}.desktop";
#     };
#   }) autostartPrograms);
# }
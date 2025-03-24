{
  fetchFromGitHub,
  stdenv
}:

stdenv.mkDerivation rec {
  pname = "plasma-window-title-applet";
  version = "0.5.5";

  src = fetchFromGitHub {
    owner = "dhruv8sh";
    repo = "plasma6-window-title-applet";
    rev = "a6eaf5086a473919ed2fffc5d3b8d98237c2dd41";
    hash = "sha256-pFXVySorHq5EpgsBz01vZQ0sLAy2UrF4VADMjyz2YLs=";
  };

  installPhase = ''
    mkdir -p $out/share/plasma/plasmoids/org.kde.windowtitle
    cp -r $src/metadata.json $src/contents $out/share/plasma/plasmoids/org.kde.windowtitle
  '';

  meta = {
    description = "Plasma 6 Window Title applet";
    homepage = "https://github.com/dhruv8sh/plasma6-window-title-applet";
  };
}

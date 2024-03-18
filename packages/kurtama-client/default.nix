let
  pkgs = import <nixpkgs> { };
in
{ stdenv ? pkgs.stdenv
, fetchurl ? pkgs.fetchurl
, makeWrapper ? pkgs.makeWrapper
, jre ? pkgs.jre
, makeDesktopItem ? pkgs.makeDesktopItem
}:

stdenv.mkDerivation rec {
  pname = "kurtama-client";
  kurtama-version = "0.0.1-alpha+20240318135836";
  version = "${kurtama-version}";

  src = fetchurl {
    url = "https://github.com/schlunzis/Kurtama/releases/download/v${kurtama-version}/kurtama-client-${kurtama-version}-linux.jar";
    hash = "sha256-5+IuL8bAemKfa8aZiqXoKuduCQdrkUGGsQNEhJUtpdI=";
  };

  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -pv $out/share/java $out/bin
    cp ${src} $out/share/java/${pname}.jar

    makeWrapper ${jre}/bin/java $out/bin/fx-demo \
      --add-flags "-jar $out/share/java/${pname}.jar" \
      --set _JAVA_OPTIONS '-Dawt.useSystemAAFontSettings=on' \
      --set _JAVA_AWT_WM_NONREPARENTING 1

    ln -sv "$desktopItem/share/applications" $out/share/
  '';

  desktopItem = makeDesktopItem {
    name = "kurtama-client";
    exec = "kurtama-client";
    icon = "kurtama-client";
    desktopName = "Kurtama";
    genericName = "Kurtama";
  };

}

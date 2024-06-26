let
  pkgs = import <nixpkgs> { };
in
{ stdenv ? pkgs.stdenv
, fetchurl ? pkgs.fetchurl
, fetchFromGitHub ? pkgs.fetchFromGitHub
, makeWrapper ? pkgs.makeWrapper
, jdk21 ? pkgs.jdk21
, makeDesktopItem ? pkgs.makeDesktopItem
}:

stdenv.mkDerivation rec {
  pname = "kurtama-client";
  kurtama-version = "0.0.1-alpha+20240603112143";
  version = "${kurtama-version}";

  jar = fetchurl {
    url = "https://github.com/schlunzis/Kurtama/releases/download/v${kurtama-version}/kurtama-client-${kurtama-version}-linux.jar";
    hash = "sha256-YSrttCIAHWts6faNRLZoCdjypwf9SBme6TCzK2fpkUo=";
  };

  src = fetchFromGitHub {
    owner = "schlunzis";
    repo = "Kurtama";
    rev = "v${version}";
    hash = "sha256-sJl+zzXGKWzmuTqwYfVoSIeiyv/2PVeAZ/JqUp1G5M4=";
  };

  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
        mkdir -pv $out/share/java $out/bin
        cp ${jar} $out/share/java/${pname}.jar

        makeWrapper ${jdk21}/bin/java $out/bin/kurtama-client \
        --add-flags "-jar $out/share/java/${pname}.jar" \
        --set _JAVA_OPTIONS '-Dawt.useSystemAAFontSettings=on' \
        --set _JAVA_AWT_WM_NONREPARENTING 1

        ln -sv "$desktopItem/share/applications" $out/share/
        mkdir -v $out/share/pixmaps
    		cp -v $src/client/src/main/resources/icons/icon-512.png $out/share/pixmaps/kurtama-client.png
  '';

  desktopItem = makeDesktopItem {
    name = "Kurtama";
    exec = "kurtama-client";
    icon = "kurtama-client";
    terminal = false;
    type = "Application";
    categories = [ "Game" ];
    startupWMClass = "org.schlunzis.kurtama.client.fx.ClientApp";
    desktopName = "Kurtama";
    genericName = "Kurtama";
  };

}

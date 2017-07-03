{ stdenv, glibcLocales, fetchFromGitHub, gtk3, python3Packages, hamster-lib, orderedset, wrapGAppsHook}:

let
  inherit (python3Packages) buildPythonPackage python pygobject3;
in buildPythonPackage rec {
  name = "hamster-gtk";
  version = "0.12-dev-1";

  src = fetchFromGitHub {
    owner = "projecthamster";
    repo = "hamster-gtk";
    rev = "06fd3c833847c11f0ca31368b35c58ee9eb839fb";
    sha256 = "0b397bilb3bs4nkdq52372992ick2p5hgbj9d8w2cwbi6xc313rk";
  };

  LC_ALL = "en_US.UTF-8";

  nativeBuildInputs = [ glibcLocales wrapGAppsHook ];

  buildInputs = [ gtk3 python pygobject3 hamster-lib orderedset ];

  preBuild = "make resources";

  postInstall = ''
    gappsWrapperArgs+=(--prefix PYTHONPATH : $PYTHONPATH)
  '';

  doCheck = false;
 
  meta = with stdenv.lib; {
    description = "A GTK3 time tracker";
    homepage = http://projecthamster.org/;
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}

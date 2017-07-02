{ stdenv, glibcLocales, fetchFromGitHub, gtk3, python3Packages, hamster-lib, orderedset, wrapGAppsHook}:

let
  inherit (python3Packages) buildPythonPackage python pygobject3;
in buildPythonPackage rec {
  name = "hamster-gtk";
  version = "0.12-dev-1";

  src = fetchFromGitHub {
    owner = "projecthamster";
    repo = "hamster-gtk";
    rev = "2052604f044cfd9691ca32023b7b9cb3badca160";
    sha256 = "18ak5mdghba9y3xih9v0fa6zk9lj4sxjqazr9ppmrq2aaqnwxnph";
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

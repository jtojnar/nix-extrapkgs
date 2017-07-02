{ stdenv, glibcLocales, fetchFromGitHub, gtk3, python3Packages, hamster-lib, orderedset, wrapGAppsHook}:

let
  inherit (python3Packages) buildPythonPackage python pygobject3;
in buildPythonPackage rec {
  name = "hamster-gtk";
  version = "0.12-dev";

  src = fetchFromGitHub {
    owner = "projecthamster";
    repo = "hamster-gtk";
    rev = "68358478e3d26f3baf02211f7ef3813ed91d0a66";
    sha256 = "1s5wf7x32drjdr5yd12n5r5d3jcjl8k8l93zfkm5fz6056ssb7pi";
  };

  LC_ALL = "en_US.UTF-8";

  nativeBuildInputs = [ glibcLocales wrapGAppsHook ];

  buildInputs = [ gtk3 python pygobject3 hamster-lib orderedset ];

  preBuild = "make resources";

  patchPhase = ''
    find hamster_gtk -type f -exec sed -i 's/backports\.//g' {} +
    sed 's/find_packages()/find_packages(exclude=["tests*"])/' -i setup.py
  '';

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

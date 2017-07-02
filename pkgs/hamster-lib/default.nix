{ stdenv, python3Packages
}:

let
  inherit (python3Packages) buildPythonPackage python fetchPypi sqlalchemy icalendar future appdirs pytest freezegun;
in buildPythonPackage rec {
  name = "hamster-lib";
  version = "0.13.1";

  src = fetchPypi {
    inherit version;
    pname = name;
    sha256 = "08cyikql62ib8gfq74mb9dmxghbgwv8d2wg1zp2p7kr35jcbnins";
  };

  nativeBuildInputs = [ pytest freezegun ];

  buildInputs = [ python ];

  propagatedBuildInputs = [ sqlalchemy icalendar future appdirs ];

  patchPhase = ''
    find tests -type f -exec sed -i 's/backports\.//g' {} +
    sed 's/find_packages()/find_packages(exclude=["tests*"])/;s/.*configparser.*//g' -i setup.py
  '';

  doCheck = false;

  meta = with stdenv.lib; {
    description = "A unified library for timetracking clients";
    homepage = http://projecthamster.org/;
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}

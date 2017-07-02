{ stdenv, buildPythonPackage, fetchPypi }:
buildPythonPackage rec {
  pname = "orderedset";
  version = "2.0";
  name = "${pname}-${version}";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0glkvclnjrhvxixa1f1gzbhrh2ac9lh78sw5fg5hpflm5i8ia61a";
  };

  doCheck = false; # No tests

  meta = {
    description = "An Ordered Set implementation in Cython";
    homepage = https://pypi.python.org/pypi/orderedset;
    license = stdenv.lib.licenses.bsd3;
  };
}

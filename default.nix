{ system ? builtins.currentSystem }:
let
  pkgs = import <nixpkgs> { inherit system; };

  callPackage = pkgs.lib.callPackageWith (pkgs // self);

  self = rec {
    orderedset = callPackage ./pkgs/orderedset { inherit (pkgs.python3Packages) buildPythonPackage fetchPypi; };
    hamster-lib = callPackage ./pkgs/hamster-lib { };
    hamster-gtk = callPackage ./pkgs/hamster-gtk {
      hamster-lib = hamster-lib;
      orderedset = orderedset;
    };
  };
in self

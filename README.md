# nix-extrapkgs

[![Build Status](https://travis-ci.org/jtojnar/nix-extrapkgs.svg?branch=master)](https://travis-ci.org/jtojnar/nix-extrapkgs)

A channel providing various derivations for [NixOS](http://nixos.org/) that are, for one reason or another, unsuitable for the main nixpkgs channel.

You can add it by issuing the following commands:

```shell
nix-channel --add https://jtojnar.github.io/nix-extrapkgs/channel/nixexprs.tar.xz extrapkgs
nix-channel --update
```

Then, you will be able to use the derivations in your `configuration.nix` in the following way:

```nix
{ pkgs, ... }:
let
  extrapkgs = import <extrapkgs> {};
in {
  environment.systemPackages = with pkgs; [
    extrapkgs.hamster-gtk
  ];
}
```

## List of packages

* [hamster-gtk](https://github.com/projecthamster/hamster-gtk) (development version)

## Acknowlegements
The initial Nix expression was based on [Fully setting up a custom private nix repository](https://www.reddit.com/r/NixOS/comments/4btjnf/fully_setting_up_a_custom_private_nix_repository/), the archive generation comes from [snabblab](https://github.com/snabblab/snabblab-nixos/blob/customchannel/jobsets/snabblab.nix#L20-L22).

#!/bin/sh

mkdir -p $OUTDIR/channel
tar cJf "$OUTDIR/channel/nixexprs.tar.xz" \
  --owner=0 --group=0 --mtime="1970-01-01 00:00:00 UTC" \
  --transform="s|^\.|extrapkgs-$TRAVIS_COMMIT|" pkgs/ default.nix
echo $TRAVIS_COMMIT > $OUTDIR/channel/git-revision

#!/bin/sh

dir_index() {
  listed_files=$1/*
  index_file=$1/index.html
  echo "<!doctype html>" >> $index_file
  echo "<html>" >> $index_file
  echo "<head>" >> $index_file
  echo "<meta charset=\"utf-8\">" >> $index_file
  echo "<title>nix-extrapkgs</title>" >> $index_file
  echo "</head>" >> $index_file
  echo "<body>" >> $index_file
  echo "<h1>nix-extrapkgs</h1>" >> $index_file
  echo "<p>Released on $(date --iso-8601=seconds) from <a href=\"https://github.com/jtojnar/nix-extrapkgs/commit/$TRAVIS_COMMIT\">Git commit $TRAVIS_COMMIT</a> via <a href=\"https://travis-ci.org/jtojnar/nix-extrapkgs/builds/$TRAVIS_BUILD_ID\">Travis build $TRAVIS_BUILD_ID</a>.</p>" >> $index_file
  echo "<table>" >> $index_file
  echo "<tr><th>File name</th><th>Size</th><th>SHA-256 hash</th></tr>" >> $index_file
  for file in $listed_files; do
    name=$(basename $file)
    size=$(stat --format=%s "$file")
    hash=$(sha256sum "$file" | awk '{print $1}')
    echo "<tr><th><a href=\"$name\">$name</a></th><th>$size</th><th>$hash</th></tr>" >> $index_file
  done
  echo "</table>" >> $index_file
  echo "</body>" >> $index_file
  echo "</html>" >> $index_file
}

mkdir -p $OUTDIR/channel
tar cJf "$OUTDIR/channel/nixexprs.tar.xz" \
  --owner=0 --group=0 --mtime="1970-01-01 00:00:00 UTC" \
  --transform="s|^\.|extrapkgs-$TRAVIS_COMMIT|" ./pkgs/ ./default.nix
echo $TRAVIS_COMMIT > $OUTDIR/channel/git-revision
dir_index $OUTDIR/channel

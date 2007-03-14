#!/bin/sh
NAME=cl-vectors
VERSION="`cat VERSION`"
FULLNAME="$NAME-$VERSION"
TARGET="./dist/$FULLNAME"
TARGZ="$TARGET.tar.gz"
if [ -e "$TARGZ" ]; then
  echo "$TARGZ already exists."
  exit 1
fi
mkdir -p "$TARGET" && rm -rf "$TARGET" && mkdir "$TARGET"
cat MANIFEST|while read FN; do cp "$FN" "$TARGET/$FN"; done
(cd "$TARGET"; sed -i 's/\$VERSION\$/'"$VERSION"'/' *.asd)
tar cvzfC "$TARGZ" "$TARGET/.." "$FULLNAME"

#!/bin/sh
NAME=cl-vectors
VERSION="`cat VERSION`"
FULLNAME="$NAME-$VERSION"
TARGET="./dist/$FULLNAME"
mkdir -p "$TARGET" && rm -rf "$TARGET" && mkdir "$TARGET"
cat MANIFEST|while read FN; do cp "$FN" "$TARGET/$FN"; done
(cd "$TARGET"; sed -i 's/\$VERSION\$/'"$VERSION"'/' *.asd)
tar cvzfC "$TARGET.tar.gz" "$TARGET/.." "$FULLNAME"

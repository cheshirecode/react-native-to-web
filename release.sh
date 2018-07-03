#!/usr/bin/env bash
# assume yarn/git available

PACKAGE=$1
PATH_TO_PACKAGE="packages/$PACKAGE"
PATH_ROOT="../../$PACKAGE"

if [ -d "$PATH_TO_PACKAGE" ];
  then
    echo "$PATH_TO_PACKAGE"
    exit 0
    cd "$PATH_TO_PACKAGE" || return
    yarn build
    git checkout gh-pages
    rm -rf "$PATH_ROOT"
    mv dist "$PATH_ROOT"
    git add -A
    git commit -m \"Website update\"
    git push origin gh-pages
    git checkout -
    cd ../../  || return
  else
    echo "$PATH_TO_PACKAGE does not exist"
    exit 1
fi
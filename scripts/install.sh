#!/usr/bin/env bash
CURRENT_FOLDER=$(pwd)

NAME=$1
if [ "$NAME" == "-d" ] || [ "$NAME" == "--debug" ];
then
  echo -e "${@:2}"
  exit
fi

if [ ! -z "$NAME" ] && [ ! -d "$NAME" ];
then
  cd "$TMPDIR" || exit
  mkdir "$NAME"
  curl -sSL https://github.com/cheshirecode/react-native-to-web/archive/master.zip | tar xJ
  mv react-native-to-web-master "$CURRENT_FOLDER/$NAME"
  cd "$CURRENT_FOLDER/$NAME" || exit
  yarn
  yarn rename
  cd ../ || exit
else
  [ ! -z "$NAME" ] && [ -d "$NAME" ] && echo "$CURRENT_FOLDER/$NAME already exists."
  echo -n "What is new project name (type and press Enter) "
  read -r NAME
  "$0" "$NAME"
  ERROR=$?
fi
[ -z "$ERROR" ] && ERROR=$?
exit $ERROR
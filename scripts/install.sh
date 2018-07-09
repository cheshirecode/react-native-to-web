#!/usr/bin/env bash
CURRENT_FOLDER=$(pwd)

NAME=$1
if [ "$NAME" = "-d" ] || [ "$NAME" = "--debug" ];
then
  echo -e "${@:2}"
  exit
fi

if [ ! -z "$NAME" ] && [ ! -d "$NAME" ];
then
  cd "$TMPDIR" || exit
  curl -sSL https://github.com/cheshirecode/react-native-to-web/archive/master.zip | tar xJ
  mv react-native-to-web-master "$CURRENT_FOLDER/$NAME"
  rm -f react-native-to-web-master
  cd "$CURRENT_FOLDER/$NAME" || exit
  yarn
  yarn rename
  cd ../ || exit
else
  # echo -n "What is new project name (type and press Enter) "
  # read -r NAME
  # "$0" "$NAME"
  echo "Requires a folder name, or folder $NAME already exists."
  cd "$CURRENT_FOLDER" || exit
  ERROR=1
fi
[ -z "$ERROR" ] && ERROR=$?
exit $ERROR
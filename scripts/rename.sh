#!/usr/bin/env bash
if [ ! -z "$1" ];
  then
    CURRENT_FOLDER_NAME=$1
  else 
    CURRENT_FOLDER_NAME=${PWD##*/}
fi
NO_HYPHEN_NAME=${CURRENT_FOLDER_NAME//-/}
npx json -I -f package.json -e "this.name=\"$CURRENT_FOLDER_NAME\""
npx json -I -f app.json -e "this.name=\"$NO_HYPHEN_NAME\"; this.displayName=\"$NO_HYPHEN_NAME\"; " 
rm -rf android ios
react-native link
react-native eject
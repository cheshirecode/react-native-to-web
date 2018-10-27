#!/usr/bin/env bash
[ ! -z "$1" ] && CURRENT_FOLDER_NAME=$1 || CURRENT_FOLDER_NAME=${PWD##*/}
NO_HYPHEN_NAME=${CURRENT_FOLDER_NAME//-/}
[ ! -z "$2" ] && BUNDLE_PREFIX="$2" || BUNDLE_PREFIX="com.company"
BUNDLE_NAME="$BUNDLE_PREFIX.$NO_HYPHEN_NAME"
npx json -I -f package.json -e "this.name=\"$CURRENT_FOLDER_NAME\""
npx json -I -f app.json -e "this.name=\"$NO_HYPHEN_NAME\"; this.displayName=\"$NO_HYPHEN_NAME\";" 
# update Android package name (iOS needs separate workflow)
npx json -I -f app.json -e "this.android = {...this.android || {}, package: \"$BUNDLE_NAME\" };" 

rm -rf android ios
react-native eject
react-native link

# update iOS bundler name, ios folder have those Info.plist files containng CFBundleIdentifier keys, 
# we need to replace <string>org.reactjs.native.example.$(PRODUCT_NAME)
# with <string>$BUNDLE_PREFIX.$(PRODUCT_NAME)
SED_EXPRESSION="s|\\(<string>\\)\\([a-zA-Z.]*\\)\\(\$(PRODUCT_NAME:[a-z0-9]*)\\)|\\1$BUNDLE_PREFIX.\\3|g"
find ./ios -name Info.plist -print0 | xargs -0 sed -i -e "$SED_EXPRESSION";
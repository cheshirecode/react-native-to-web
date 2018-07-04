#!/usr/bin/env bash
read -r -d '' HELP_TEXT <<- EOF
  usage: rntw-scripts [command]

    rename <name> - rename RN project to current folder name or specified <name>
    web - start dev server with a Web version of RN project
    web:build - build Web version of RN project
    reinstall - clean out caches/npm modules/watchman and install again
    storybook - start Storybook dev server

  Bugs - 
EOF

if [[ $# -eq 0 ]] ; then
  echo -e "$HELP_TEXT"
  exit 0
fi

NAME=$1
RESPONSE=""
shift
CURRENT_FOLDER_NAME=${PWD##*/}
case "$NAME" in
"storybook"|"styleguidist"*)
  cd "packages/$NAME" || return
  yarn start
  ;;
"rename"*)
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
  ;;
"web:build"*)
  NODE_ENV=production node_modules/.bin/webpack -p --config ./webpack.config.js
  ;;
"web"*)
  node_modules/.bin/webpack-dev-server -d --config ./webpack.config.js \
    --inline --hot --colors --content-base public/ \
    --history-api-fallback
  ;;
"clean:bundler"*)
  rm -rf watch-del-all
  rm -rf "$TMPDIR/metro*"
  echo "Cleared Metro bundler-related caches"
  ;;
"clean:packages"*)
  rm -rf node_modules/ packages/*/node_modules
  yarn cache clean
  echo "Cleared npm modules and cache"
  ;;
"reinstall"*)
  "$0" clean:bundler &
  e1=$!
  "$0" clean:packages &
  e2=$!
  # wait until both are finished and collect exit codes
  wait
  yarn
  ERROR=$e1 || $e2 || $!
  ;;
*)
  RESPONSE="$HELP_TEXT"
  ;;
esac
[ -z "$ERROR" ] && ERROR=$?
[ ! -z "$RESPONSE" ] && echo "$RESPONSE"
exit $ERROR
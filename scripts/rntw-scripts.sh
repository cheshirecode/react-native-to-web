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

error_msg() {
  read -r -d '' ERROR_MSG <<- EOF
  Invalid command "$1". Refer to help text.
EOF
  echo "$ERROR_MSG"
}

if [[ $# -eq 0 ]] ; then
  echo -e "$HELP_TEXT"
  exit 0
fi

# assume this is run at 
COMMAND=$1
SCRIPT_PATH=$(dirname "$0")
RESPONSE=""

case "$COMMAND" in
"-h|--help"*)
  RESPONSE="$HELP_TEXT"
  ;;
"storybook"|"styleguidist"*)
  cd "packages/$COMMAND" || return
  yarn start
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
"clean"*)
  "$0" clean:bundler &
  p1=$!
  "$0" clean:packages &
  p2=$!
  # wait until both are finished and collect exit codes
  wait $p1
  e1=$?
  wait $p2
  e2=$?
  ERROR=$e1 || $e2
  ;;
"reinstall"*)
  "$0" clean
  yarn
  ;;
*)
  # just pass arguments after command to the matching script name (rename -> rename.sh)
  if [ -f "$SCRIPT_PATH/$COMMAND.sh" ];
  then
    "$SCRIPT_PATH/$COMMAND.sh" "${@:2}"
  else
    RESPONSE=$(error_msg "$COMMAND")
  fi
  ;;
esac
[ -z "$ERROR" ] && ERROR=$?
[ ! -z "$RESPONSE" ] && echo "$RESPONSE"
exit $ERROR
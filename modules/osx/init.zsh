#
# dotzsh : https://github.com/dotzsh/dotzsh
#
# Defines Mac OS X aliases and functions.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Ben O'Hara <bohara@gmail.com>
#

# This module is for Mac OS X only.
if [[ "$OSTYPE" != darwin* ]]; then
  return 4
fi

# Change directory to the current Finder directory.
alias cdf='cd "$(pfd)"'

# Push directory to the current Finder directory.
alias pushdf='pushd "$(pfd)"'

zstyle -b ':dotzsh:module:osx' launcher '_osx_launcher'
if is-true "${_osx_launcher}"; then
  app_dirs=(~/Applications /Applications /System/Library/CoreServices)
  for dir in $app_dirs
  do
    if [[ -d $dir ]]; then
      for app in $(find "$dir" -maxdepth 2 -iname "*.app" | tr ' ' '^')
      do
        app="$(echo "$app" | egrep -o '([^/]+)\.app')"
        app="${app%.app}"
        app_name="$(echo "$app" | tr '^' ' ')"
        app_command="$(echo "$app" | tr -d '^' | tr '[A-Z]' '[a-z]')"
        alias "$app_command"="open -a \"$app_name"\"
      done
    fi
  done
fi

if [[ -s /usr/bin/firefox ]] ; then
  unalias firefox
fi

# Open files in Quick Look.
function ql {
  (( $# > 0 )) && qlmanage -p "$@" &> /dev/null
}

# Delete .DS_Store and __MACOSX directories.
function rm-osx-cruft {
  find "${@:-$PWD}" \( \
    -type f -name '.DS_Store' -o \
    -type d -name '__MACOSX' \
  \) -print0 | xargs -0 rm -rf
}


#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Provides Git aliases and functions.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Ben O'Hara <bohara@gmail.com>
#

if (( ! $+commands[git] )); then
  return 1
fi

if (( $+commands[hub]  )); then
  function git {
    hub "$@"
  }
fi


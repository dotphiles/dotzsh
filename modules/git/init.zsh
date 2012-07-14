#
# dotzsh : https://github.com/dotphiles/dotzsh-module-git
#
# Provides Git aliases and functions.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

if (( ! $+commands[git] )); then
  return 2
fi

if (( $+commands[hub]  )); then
  function git {
    hub "$@"
  }
fi


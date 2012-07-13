#
# dotzsh : https://github.com/dotzsh/dotzsh-module-git
#
# Provides Git aliases and functions.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

if (( ! $+commands[git] )); then
  return 2
fi

# Source module files.
zstyle -b ":dotzsh:module:git" aliases '_git_aliases'
if ( is-true ${_git_aliases} ); then
  source "${0:h}/aliases.zsh"
fi

source "${0:h}/hub.zsh"

unset _git_aliases

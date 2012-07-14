#
# dotzsh : https:/github.com/dotphiles/dotzsh
#
# Defines Yaourt aliases.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Disable color.
if ! zstyle -t ':dotzsh:module:pacman:yaourt' color; then
  alias pacman='pacman --nocolor'
fi

# Manages .pac* files.
alias pacc='pacman -C'


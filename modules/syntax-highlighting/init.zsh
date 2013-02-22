#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Integrates zsh-syntax-highlighting into dotzsh.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Ben O'Hara <bohara@gmail.com>
#

# Check for the minimum supported version.
local min_zsh_version='4.3.9'
if ! autoload -Uz is-at-least || ! is-at-least "$min_zsh_version"; then
  return 1
fi

if [[ ! -s ${0:h}/external/zsh-syntax-highlighting.zsh ]]; then
  return 1
fi

if zstyle -t ':dotzsh:module:syntax-highlighting' color; then
  source "${0:h}/external/zsh-syntax-highlighting.zsh"

  # Set the highlighters.
  zstyle -a ':dotzsh:module:syntax-highlighting' highlighters 'ZSH_HIGHLIGHT_HIGHLIGHTERS'
  if (( ${#ZSH_HIGHLIGHT_HIGHLIGHTERS[@]} == 0 )); then
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor)
  fi
fi


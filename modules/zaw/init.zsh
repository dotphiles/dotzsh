#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Integrates zaw into dotzsh.
#
# Authors:
#   Ben O'Hara <bohara@gmail.com>
#

# Check for the minimum supported version.
local min_zsh_version='4.3.10'
if ! autoload -Uz is-at-least || ! is-at-least "$min_zsh_version"; then
  return 1
fi

if [[ -s "${0:h}/external/zaw.zsh" ]]; then
  source "${0:h}/external/zaw.zsh"
else
  return 1
fi

bindkey '^R' zaw-history
bindkey -M filterselect '^R' down-line-or-history
bindkey -M filterselect '^S' up-line-or-history
bindkey -M filterselect '^E' accept-search

zstyle ':filter-select:highlight' matched fg=green
zstyle ':filter-select:highlight' title fg=yellow
zstyle ':filter-select:highlight' error fg=red
zstyle ':filter-select' max-lines 10 # use 10 lines for filter-select
zstyle ':filter-select' rotate-list yes # enable rotation for filter-select
zstyle ':filter-select' case-insensitive yes # enable case-insensitive search
zstyle ':filter-select' extended-search yes # see below


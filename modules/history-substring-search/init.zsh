#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Integrates history-substring-search into dotzsh.
#
# Authors:
#   Suraj N. Kurapati <sunaku@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Check for the minimum supported version.
local min_zsh_version='4.3.10'
if ! autoload -Uz is-at-least || ! is-at-least "$min_zsh_version"; then
  return 9
fi

if [[ -s "${0:h}/external/zsh-history-substring-search.zsh" ]]; then
  source "${0:h}/external/zsh-history-substring-search.zsh"
else
  return 2
fi

if zstyle -t ':dotzsh:module:history-substring-search' case-sensitive; then
  unset HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS
fi

if ! zstyle -t ':dotzsh:module:history-substring-search' color; then
  unset HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_{FOUND,NOT_FOUND}
fi

bindkey -M emacs "$key_info[Control]P" history-substring-search-up
bindkey -M emacs "$key_info[Control]N" history-substring-search-down
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down


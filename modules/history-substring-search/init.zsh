#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Integrates history-substring-search into dotzsh.
#
# Authors:
#   Suraj N. Kurapati <sunaku@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Ben O'Hara <bohara@gmail.com>
#

# Check for the minimum supported version.
local min_zsh_version='4.3.10'
if ! autoload -Uz is-at-least || ! is-at-least "$min_zsh_version"; then
  return 1
fi

if [[ -s "${0:h}/external/zsh-history-substring-search.zsh" ]]; then
  source "${0:h}/external/zsh-history-substring-search.zsh"
else
  return 1
fi

if zstyle -t ':dotzsh:module:history-substring-search' case-sensitive; then
  unset HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS
fi

if ! zstyle -t ':dotzsh:module:history-substring-search' color; then
  unset HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_{FOUND,NOT_FOUND}
fi

#
# Key Bindings
#

if [[ -n "$key_info" ]]; then
  # Emacs
  bindkey -M emacs "$key_info[Control]P" history-substring-search-up
  bindkey -M emacs "$key_info[Control]N" history-substring-search-down

  # Vi
  bindkey -M vicmd "k" history-substring-search-up
  bindkey -M vicmd "j" history-substring-search-down

  # Emacs and Vi
  for keymap in 'emacs' 'viins'; do
    bindkey -M "$keymap" "$key_info[Up]" history-substring-search-up
    bindkey -M "$keymap" "\e[A" history-substring-search-up
    bindkey -M "$keymap" "$key_info[Down]" history-substring-search-down
    bindkey -M "$keymap" "\e[B" history-substring-search-down
  done
fi


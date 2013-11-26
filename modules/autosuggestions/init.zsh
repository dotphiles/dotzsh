#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Integrates zsh-autosuggestions into dotzsh.
#
# Authors:
#   Ben O'Hara <bohara@gmail.com>
#

# Check for the minimum supported version.
local min_zsh_version='4.3.10'
if ! autoload -Uz is-at-least || ! is-at-least "$min_zsh_version"; then
  return 1
fi

if [[ -s "${0:h}/external/autosuggestions.zsh" ]]; then
  source "${0:h}/external/autosuggestions.zsh"
else
  return 1
fi

# Enable autosuggestions automatically
zle-line-init() {
    zle autosuggest-start
}
zle -N zle-line-init

# use ctrl+t to toggle autosuggestions(hopefully this wont be needed as
# zsh-autosuggestions is designed to be unobtrusive)
bindkey '^T' autosuggest-toggle


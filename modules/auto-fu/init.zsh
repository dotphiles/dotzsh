source "${0:h}/external/auto-fu.zsh"

zle-line-init () {auto-fu-init;}; zle -N zle-line-init

zstyle ':completion:*' completer _oldlist _complete

zle -N zle-keymap-select auto-fu-zle-keymap-select

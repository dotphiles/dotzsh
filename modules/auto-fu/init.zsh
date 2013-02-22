#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Setup auto-fu, automatic completion
#
# Authors:
#   Ben O'Hara <bohara@gmail.com>

source "${0:h}/external/auto-fu.zsh"

zle-line-init () {auto-fu-init;}; zle -N zle-line-init

zstyle ':completion:*' completer _oldlist _complete

zle -N zle-keymap-select auto-fu-zle-keymap-select


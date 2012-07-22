#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Setup colors for ls, grep etc
#
# Authors:
#   Ben O'Hara <bohara@gmail.com>
#

zstyle ':dotzsh:module:theme:dircolors:dotphiles' theme 'dircolors/dircolors.256dark'
zstyle ':dotzsh:module:theme:lscolors:dotphiles' theme 'gxfxbEaEBxxEhEhBaDaCaD'
zstyle ':dotzsh:module:theme:grepcolors:dotphiles' theme '37;45'

# Patterns
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('sudo' 'fg=white,bold,bg=red')


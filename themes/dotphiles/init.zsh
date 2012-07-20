#
# dotzsh-prompt-dotphiles : https://github.com/dotphiles/dotzsh-prompt-dotphiles
#
# Setup colors for ls, grep etc
#

zstyle ':dotzsh:module:theme:dircolors:dotphiles' theme 'dircolors/dircolors.256dark'
zstyle ':dotzsh:module:theme:lscolors:dotphiles' theme 'gxfxbEaEBxxEhEhBaDaCaD'
zstyle ':dotzsh:module:theme:grepcolors:dotphiles' theme '37;45'

# Patterns
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('sudo' 'fg=white,bold,bg=red')


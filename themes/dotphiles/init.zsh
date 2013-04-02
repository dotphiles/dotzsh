#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Setup colors for ls, grep etc
#
# Authors:
#   Ben O'Hara <bohara@gmail.com>
#

if [[ "$_theme[2]" = "zenburn" ]]; then
  zstyle ':dotzsh:module:theme:dircolors:dotphiles' theme 'dircolors/dircolors.zenburn'
  zstyle ':dotzsh:module:theme:lscolors:dotphiles' theme 'gxfxbEaEBxxEhEhBaDaCaD'
elif [[ "$_theme[2]" = "sollight" ]]; then
  zstyle ':dotzsh:module:theme:dircolors:dotphiles' theme 'dircolors/dircolors.ansi-light'
  zstyle ':dotzsh:module:theme:lscolors:dotphiles' theme 'gxfxbEaEBxxEhEhBaDaCaD'
else
  zstyle ':dotzsh:module:theme:dircolors:dotphiles' theme 'dircolors/dircolors.256dark'
  zstyle ':dotzsh:module:theme:lscolors:dotphiles' theme 'gxfxbEaEBxxEhEhBaDaCaD'
fi

if [[ $TERM = *256color || $TERM = *rxvt* ]]; then
  zstyle ':dotzsh:module:theme:grepcolors:dotphiles' theme '00;38;5;254;48;5;160'
else
  zstyle ':dotzsh:module:theme:grepcolors:dotphiles' theme '37;45'
fi

# Patterns
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('sudo' 'fg=white,bold,bg=red')


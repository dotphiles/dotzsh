#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Setup colors for ls, grep etc
#
# Authors:
#   Ben O'Hara <bohara@gmail.com>
#

if [[ "$_theme[2]" == ".*\.light" ]] || [[ "$LC_TERM_PROFILE" == ".*\.light" ]]; then
  zstyle ':dotzsh:module:theme:dircolors:dotphiles' theme 'dircolors/dircolors.base16.light'
else
  zstyle ':dotzsh:module:theme:dircolors:dotphiles' theme 'dircolors/dircolors.base16.dark'
  _theme[2]="base16-default.dark"
fi

zstyle ':dotzsh:module:theme:lscolors:dotphiles' theme 'gxfxbEaEBxxEhEhBaDaCaD'

# Patterns
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('sudo' 'fg=white,bold,bg=red')


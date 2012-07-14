#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Defines Dotsync aliases.
#
# Authors:
#   Ben O'Hara <bohara@gmail.com>
#

if (( ! $+commands[dotsync] )); then
  return 1
fi

if [[ -f $HOME/.dotsyncrc ]]; then
  export DOTFILES=`grep "DOTFILES=" $HOME/.dotsyncrc | grep -v "^#" | awk -F\= '{print $2}'`
  if [[ -z $DOTFILES ]]; then
    DOTFILES=".dotfiles"
  fi
fi

# Aliases
alias ds="dotsync"
alias dsU="dotsync -U"
alias dsA="dotsync -A"
alias dsL="dotsync -L"
alias dsl="dotsync -l"
alias cdot="cd $HOME/$DOTFILES"


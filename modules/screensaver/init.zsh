#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Simple scrensaver module
#
# Authors:
#   Ben O'Hara <bohara@gmail.com>
#

zstyle -a ':dotzsh:module:screensaver' timeout '_timeout'

if (( $#_timeout > 0  )); then
  TMOUT="$_timeout[@]"
else
  TMOUT=120
fi

TRAPALRM() {
  if (( ! $+commands[cmatrix]  )); then
    cmatrix -s
  fi
}


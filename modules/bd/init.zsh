#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Integrates zaw into dotzsh.
#
# Authors:
#   Ben O'Hara <bohara@gmail.com>
#

if [[ -s "${0:h}/external/bd.zsh" ]]; then
  source "${0:h}/external/bd.zsh"
else
  return 1
fi

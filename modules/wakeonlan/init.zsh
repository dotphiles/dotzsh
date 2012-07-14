#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Authors:
#   Ben O'Hara <bohara@gmail.com>
#

if (( ! $+commands[wakeonlan] )); then
  return 2
fi


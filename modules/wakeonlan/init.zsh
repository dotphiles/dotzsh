#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Setup wake on lan
#
# Authors:
#   Ben O'Hara <bohara@gmail.com>
#

if (( ! $+commands[wakeonlan] )); then
  return 1
fi


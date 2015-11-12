#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Defines puppet environment
#
# Authors:
#   Ben O'Hara <bohara@gmail.com>
#


if (( $+commands[puppet] )); then
  alias pa='puppet agent --test '
  alias pA='puppet agent --test --noop '
fi

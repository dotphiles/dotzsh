#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Provides Vagrant aliases
#
# Authors:
#   Ben O'Hara <bohara@gmail.com>
#

if (( ! $+commands[vagrant] )); then
  return 1
fi

alias v='vagrant'
alias vs='vagrant suspend'
alias vp='vagrant provision'
alias vu='vagrant up'
alias vh='vagrant halt'
alias vss='vagrant ssh'


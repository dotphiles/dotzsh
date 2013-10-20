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

alias va='vagrant'
alias vs='vagrant suspend'
alias vp='vagrant provision'
alias vu='vagrant up'
alias vh='vagrant halt'
alias vd='vagrant destroy'
alias vss='vagrant ssh'


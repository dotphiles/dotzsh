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
alias vS='vagrant suspend'
alias vp='vagrant provision'
alias vu='vagrant up'
alias vr='vagrant reload'
alias vH='vagrant halt'
alias vD='vagrant destroy'
alias vs='vagrant ssh'
alias vst='vagrant status'


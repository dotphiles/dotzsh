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
alias vp='VAGRANT_PUPPET_OPTIONS="--noop --verbose --show_diff" vagrant provision'
alias vP='VAGRANT_PUPPET_OPTIONS="--verbose --show_diff" vagrant provision'
alias vpd='VAGRANT_PUPPET_OPTIONS="--noop --debug --show_diff" vagrant provision'
alias vPd='VAGRANT_PUPPET_OPTIONS="--debug --show_diff" vagrant provision'
alias vu='vagrant up'
alias vr='vagrant reload'
alias vH='vagrant halt'
alias vD='vagrant destroy'
alias vs='vagrant ssh'
alias vst='vagrant status'


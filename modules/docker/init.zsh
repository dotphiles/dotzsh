#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Defines docker environment
#
# Authors:
#   Ben O'Hara <bohara@gmail.com>
#

alias dl='docker ps -l -q'

if (( $+commands[docker] && $+commands[boot2docker] )); then
  $(boot2docker shellinit 2>/dev/null |grep -v Writing )
  export DOCKER_TLS_VERIFY=1
  export FORWARD_DOCKER_PORTS=1
fi

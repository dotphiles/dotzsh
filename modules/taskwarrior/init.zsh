#
# dotzsh : https://github.com/dotphiles/dotzsh
#
#  Setup Taskwarrior
#
#  Authors:
#    Ben O'Hara <bohara@gmail.com>
#

if (( ! $+commands[task] )); then
  return 1
fi

zstyle ':completion:*:*:task:*' verbose yes
zstyle ':completion:*:*:task:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:*:task:*' group-name ''

alias t=task


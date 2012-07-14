#
# dotzsh : https://github.com/dotphiles/dotzsh
#
#  Setup Taskwarrior
#
#  Authors:
#    Ben O'Hara <bohara@gmail.com>
#

zstyle ':completion:*:*:task:*' verbose yes
zstyle ':completion:*:*:task:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:*:task:*' group-name ''

alias t=task


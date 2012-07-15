#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Setup Mercurial
#
# Authors:
#   Ben O'Hara <bohara@gmail.com>
#

if (( ! $+commands[hg] )); then
  return 1
fi

alias hgc='hg commit'
alias hgb='hg branch'
alias hgba='hg branches'
alias hgco='hg checkout'
alias hgd='hg diff'
alias hged='hg diffmerge'
# pull and update
alias hgl='hg pull -u'
alias hgp='hg push'
alias hgs='hg status'
# this is the 'git commit --amend' equivalent
alias hgca='hg qimport -r tip ; hg qrefresh -e ; hg qfinish tip'


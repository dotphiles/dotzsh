#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Provides for an easier use of gpg-agent.
#
# Authors:
#   Florian Walch <florian.walch@gmx.at>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Ben O'Hara <bohara@gmail.com>
#

if (( ! $+commands[gpg-agent] )); then
  return 1
fi

# Make sure to use the $GNUPGHOME first.
_gpg_env="${GNUPGHOME:-$HOME/.gnupg}/gpg-agent.env"

function _gpg-agent-start {
  local ssh_support

  zstyle -b ':dotzsh:module:gnupg' agent-ssh-support 'ssh_support' \
    || ssh_support=''

  gpg-agent \
    --daemon ${ssh_support:+'--enable-ssh-support'} \
    --write-env-file "${_gpg_env}" > /dev/null

  chmod 600 "${_gpg_env}"
  source "${_gpg_env}" > /dev/null
}

# Source GPG agent settings, if applicable.
if [[ -s "${_gpg_env}" ]]; then
  source "${_gpg_env}" > /dev/null
  if [[ "$SSH_AGENT" == "" ]]; then
    _agent_pid=`echo ${GPG_AGENT_INFO} | awk -F":" '{print $2}'`
  else
     _agent_pid=$SSH_AGENT
  fi
  ps -ef | grep "${_agent_pid}" | grep -q 'gpg-agent' || {
    _gpg-agent-start
  }
else
  pkill gpg-agent
  _gpg-agent-start
fi

export GPG_AGENT_INFO
export SSH_AUTH_SOCK
export SSH_AGENT_PID
export GPG_TTY="$(tty)"

alias gpgas='gpg --export -a'
alias gpgh='gpg --help|$PAGER'
alias gpgks='gpg --search-keys'
alias gpgl='gpg --list-keys --with-fingerprint'
alias gpgkS='gpg --sign-key'
alias gpgls='gpg --list-sigs'
alias gpgen='gpg -e -r $1 $2'
alias gpgde='gpg -d $1'
alias gpgrk='gpg --recv-keys $1'
alias gpgcl='gpg --clearsign $1'
alias gpgfp='gpg --fingerprint $1'
alias gpgsk='gpg --send-keys $1'


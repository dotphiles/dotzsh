#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Setup ssh and ssh-agent
#
# Authors:
#   Robby Russell <robby@planetargon.com>
#   Theodore Robert Campbell Jr <trcjr@stupidfoot.com>
#   Joseph M. Reagle Jr. <reagle@mit.edu>
#   Florent Thoumie <flz@xbsd.org>
#   Jonas Pfenniger <jonas@pfenniger.name>
#   gwjo <gowen72@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Ben O'Hara <bohara@gmail.com>
#

if (( ! $+commands[ssh] || ! $+commands[ssh-agent] )); then
  return 1
fi

# Aliases

# zstyle hangs with no known_hosts
if [[ -f "${HOME}/.ssh/known_hosts" ]]; then
  # add an alias to ssh for known hosts
  zstyle -b ':dotzsh:module:ssh:aliases' hosts '_ssh_host_aliases'
  if is-true "${_ssh_host_aliases}"; then
    zstyle -a ":completion:*:ssh:hosts" hosts hosts
    if (( $#hosts > 0 )); then
      for host in $hosts; do
      if [[ ! "$host" == (*.*|*:*|$HOST|loopback|ip6-loopback|localhost|\
        ip6-localhost|ip6-allhosts|ip6-allnodes|ip6-allrouters|ip6-localnet|\
        ip6-mcastprefix|localhost4|localhost6|broadcasthost) ]]; then
        if (( !$+commands[$host] )); then
          alias $host="${aliases[ssh]:-ssh} $host"
        fi
      fi
      done
    fi
  fi
fi

for _ssh_alias in \1 \2 \4 \6 \A \C \D \F \I \L \M \N \O \P \R \S \T \V \X \
                  \Y \a \b \c \e \f \g \i \k \l \m \n \o \p \q \s \t \v \x
do
  alias "ssh${_ssh_alias}"="ssh -${_ssh_alias}"
done
unset _ssh_alias

# Functions

_ssh_agent_env="${HOME}/.ssh/environment-${HOST}"
_ssh_agent_forwarding=

function _ssh-agent-start {
  local -a identities

  # Start ssh-agent and setup the environment.
  rm -f "${_ssh_agent_env}"
  ssh-agent > "${_ssh_agent_env}"
  chmod 600 "${_ssh_agent_env}"
  source "${_ssh_agent_env}" > /dev/null

  # Load identities.
  zstyle -a ':dotzsh:module:ssh:agent' identities 'identities'

  if (( ${#identities} > 0 )); then
    ssh-add "${HOME}/.ssh/${^identities[@]}"
  else
    ssh-add
  fi
}

# Test if agent-forwarding is enabled.
zstyle -b ':dotzsh:module:ssh:agent' forwarding '_ssh_agent_forwarding'
if is-true "${_ssh_agent_forwarding}" && [[ -n "$SSH_AUTH_SOCK" ]]; then
  # Add a nifty symlink for screen/tmux if agent forwarding.
  if [[ ! -L "$SSH_AUTH_SOCK" ]]; then
    ln -sf "$SSH_AUTH_SOCK" /tmp/ssh-agent-$USER && export SSH_AUTH_SOCK=/tmp/ssh-agent-$USER
  fi
elif [[ -s "${_ssh_agent_env}" ]]; then
  # Source SSH settings, if applicable.
  source "${_ssh_agent_env}" > /dev/null
  ps -ef | grep "${SSH_AGENT_PID}" | grep -q 'ssh-agent$' || {
    _ssh-agent-start;
  }
else
  _ssh-agent-start;
fi

# Tidy up after ourselves.
unfunction _ssh-agent-start
unset _ssh_agent_{env,forwarding}


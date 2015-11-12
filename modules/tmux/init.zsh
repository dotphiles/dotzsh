#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Defines tmux aliases and provides for auto launching it at start-up.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Colin Hebert <hebert.colin@gmail.com>
#   Ben O'Hara <bohara@gmail.com>
#

if (( ! $+commands[tmux] )); then
  return 1
fi

# Auto Start
if [[ -z "$TMUX" ]] && ( zstyle -t ':dotzsh:module:tmux' auto-start \
    || ( [[ -n "$SSH_TTY" ]] && zstyle -m ':dotzsh:module:tmux' auto-start 'remote' ) \
    || ( [[ -z "$SSH_TTY" ]] && zstyle -m ':dotzsh:module:tmux' auto-start 'local' ) ); then

  zstyle -a ':dotzsh:module:tmux' auto-session-name '_session_name'

  if ! tmux has-session -t "$_session_name" 2> /dev/null; then
    # Disable the destruction of unattached sessions globally.
    tmux set-option -g destroy-unattached off &> /dev/null

    # Create a new session.
    tmux new-session -d -s "$_session_name"

    # Disable the destruction of the new, unattached session.
    tmux set-option -t "$_session_name" destroy-unattached off &> /dev/null

    # Enable the destruction of unattached sessions globally to prevent
    # an abundance of open, detached sessions.
    tmux set-option -g destroy-unattached on &> /dev/null
  fi

  exec tmux attach -t "$_session_name"
fi

# Aliases
alias ta='tmux attach-session -t '
alias tl='tmux list-sessions'

if (( $+commands[tmuxinator] )); then
  source ${0:h}/tmuxinator.zsh
fi

if (( $+commands[tmuxp] )); then
  source ${0:h}/tmuxp.zsh
fi


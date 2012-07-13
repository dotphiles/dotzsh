#
# dotzsh : https://github.com/dotzsh/dotzsh
#
# Defines GNU Screen aliases and provides for auto launching it at start-up.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

if (( ! $+commands[screen] )); then
  return 2
fi

# Auto Start
if [[ -z "$STY" ]] && zstyle -t ':dotzsh:module:screen' auto-start; then
  session="$(
    screen -list 2> /dev/null \
      | sed '1d;$d' \
      | awk '{print $1}' \
      | head -1)"

  if [[ -n "$session" ]]; then
    exec screen -x "$session"
  else
    exec screen -a -A -U -D -R -m "$SHELL" -l
  fi
fi

# Aliases
alias sl="screen -list"
alias sn="screen -U -S"
alias sr="screen -a -A -U -D -R"


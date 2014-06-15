#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Provides for auto launching dtach at start-up.
#
# Authors:
#   Michele Campeotto <micampe@micampe.it>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Ben O'Hara <bohara@gmail.com>
#

if (( ! $+commands[dtach] )); then
  return 1
fi

# Auto Start
if [[ -z "$STY" ]] && ( zstyle -t ':dotzsh:module:dtach' auto-start \
    || ( [[ -n "$SSH_TTY" ]] && zstyle -m ':dotzsh:module:dtach' auto-start 'remote' ) \
    || ( [[ -z "$SSH_TTY" ]] && zstyle -m ':dotzsh:module:dtach' auto-start 'local' ) ); then

  session="/tmp/dtach-main-session"
  if [[ ${dotzsh_dtach_started} == '' ]]; then
    echo "connecting to dtach session..."
    sleep 1
    export dotzsh_dtach_started=1

    zstyle -a ':dotzsh:module:dtach' detach-char '_dotzsh_dtach_detach_char'
    exec dtach -A ${session} -e ${_dotzsh_dtach_detach_char:-^\\} -r winch zsh
  fi
fi

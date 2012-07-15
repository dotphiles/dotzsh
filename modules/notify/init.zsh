#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Notify when long running commands finish with growl on OSX
#
# Authors:
#   Ben O'Hara <bohara@gmail.com>
#

if (( ! $+commands[growlnotify] )); then
  return 1
fi

zstyle -a ':dotzsh:module:notify' elapsed '_elapsed'
if (( $#_elapsed > 0 )); then
  notify_max="$_elapsed[@]"
fi

notify_preexec() {
  notify_cmd=$1
  notify_time=`date +%s%N`
}

notify_precmd() {
  exitstatus=$?
  stop=$(date +'%s%N')
  start=${notify_time:-$stop}
  let elapsed=$stop-$start
  let elapsedsecs=$(($elapsed / 1000000000 % 1000000000))

  max=${notify_max:-30}
  alias_notify_cmd=`alias $notify_cmd | awk -F"'" '{print $2}'`
  if [[ "$alias_notify_cmd" == "" ]]; then
    alias_notify_cmd=$notify_cmd
  fi
  if [[ ! "$alias_notify_cmd" == (vi*|vim*|top|ssh*|cmatrix|telnet*|tmux*|mux*|) ]]; then
    if [[ $elapsedsecs -gt $max ]]; then
      if [[ $exitstatus == 0 ]]; then
        message="Completed after $(format-elapsed $elapsed)"
      else
        message="Failed with status $exitstatus after $(format-elapsed $elapsed)"
      fi
      growlnotify -n "dotzshnotify" -m ${message} ${notify_cmd:-Some command}
    fi
  fi
  notify_cmd=
  notify_time=
}

add-zsh-hook preexec notify_preexec
add-zsh-hook precmd notify_precmd


#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Notify when long running commands finish with growl on OSX Lion
# or terminal-notify on OSX Mountain Lion.
#
# Authors:
#   Ben O'Hara <bohara@gmail.com>
#

min_zsh_version='4.3.10'
if ! autoload -Uz is-at-least && is-at-least "$min_zsh_version"; then
  return 1
fi

if [[ ! -z $SSH_CONNECTION ]]; then
  return 1
fi

if (( $+commands[terminal-notifier] )); then
  dotzsh_notify_exec="terminal-notifier"
elif [[ -d /Applications/terminal-notifier.app ]]; then
  dotzsh_notify_exec="/Applications/terminal-notifier.app/Contents/MacOS/terminal-notifier"
elif (( $+commands[growlnotify] )); then
  dotzsh_notify_exec="growlnotify"
else
  return 1
fi

zstyle -b ':dotzsh:module:notify' different-window-only '_different_window_only'

zstyle -a ':dotzsh:module:notify' elapsed '_elapsed'
if (( $#_elapsed > 0 )); then
  notify_max="$_elapsed[@]"
fi

function dotzsh-notify {
  if (( $+commands[growlnotify] )); then
    ${dotzsh_notify_exec} -n "dotzsh-notify" -m ${1} ${2}
  elif [[ ! "$dotzsh_notify_exec" == "" ]]; then
    ${dotzsh_notify_exec} -group "dotzsh-notify" -message ${1} -title ${2} > /dev/null
  else
    echo "Install growlnotify or terminal-notifier to use the dotzsh notify module"
    echo "$2: $1"
  fi
}

function frontmost-window-id {
    osascript -e 'tell application (path to frontmost application as text) to id of front window' 2&> /dev/null
}

function should-notify {
  if is-true ${_different_window_only}; then
    current_win_id=`frontmost-window-id`
    [[ ! "$current_win_id" == "$notify_win_id" ]]
  else
    [[ ! "$1" == (vi|vim|git|top|ssh|cmatrix|telnet|tmux*|mux|man|workon|vagrant) ]]
  fi
}

notify_preexec() {
  notify_cmd=$1
  notify_time=`date +%s`
  if is-true ${_different_window_only}; then
    notify_win_id=`frontmost-window-id`
  fi
}

notify_precmd() {
  exitstatus=$?
  stop=$(date +'%s')
  start=${notify_time:-$stop}
  let elapsed=$stop-$start

  max=${notify_max:-30}
  if [[ $notify_cmd != "" ]]; then
    alias_notify_cmd=`alias $(echo $notify_cmd | awk '{print $1}') | awk -F"'" '{print $2}'|awk '{print $1}'`
    if [[ "$alias_notify_cmd" == "" ]]; then
      alias_notify_cmd=$notify_cmd[(w)1]
    fi
    if [[ $elapsed -gt $max ]]; then
      if should-notify $alias_notify_cmd; then
        let elapsed_ns=$(($elapsed * 1000000000))
        if [[ $exitstatus == 0 ]]; then
          message="Completed after $(format-elapsed $elapsed_ns)"
        else
          message="Failed with status $exitstatus after $(format-elapsed $elapsed_ns)"
        fi

        dotzsh-notify ${message} ${alias_notify_cmd:-Some command}
      fi
    fi
  fi
  notify_cmd=
  notify_time=
  notify_win_id=
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec notify_preexec
add-zsh-hook precmd notify_precmd

#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Sets terminal window and tab titles.
#
# Authors:
#   James Cox <james@imaj.es>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Ben O'Hara <bohara@gmail.com>
#

# Check for the minimum supported version.
local min_zsh_version='4.3.10'
if ! autoload -Uz is-at-least || ! is-at-least "$min_zsh_version"; then
  return 1
fi

# Dumb terminals lack support.
if [[ "$TERM" == (dumb|linux|*bsd*) ]]; then
  return 1
fi

# Solaris has no 256 colors!
if [[ "$OSTYPE" = solaris* ]]; then
  export TERMINFO=/usr/gnu/share/terminfo
fi

# Set the GNU Screen window number.
if [[ -n "$WINDOW" ]]; then
  export SCREEN_NO="%B${WINDOW}%b "
else
  export SCREEN_NO=""
fi

# Sets the GNU Screen title.
function set-screen-title {
  if [[ "$TERM" == screen* ]]; then
    printf "\ek%s\e\\" ${(V)argv}
  fi
}

# Sets the terminal window title.
function set-window-title {
  if [[ "$TERM" == ((x|a|ml|dt|E)term*|(u|)rxvt*) ]]; then
    printf "\e]2;%s\a" ${(V)argv}
  fi
}

# Sets the terminal tab title.
function set-tab-title {
  if [[ "$TERM" == ((x|a|ml|dt|E)term*|(u|)rxvt*) ]]; then
    printf "\e]1;%s\a" ${(V)argv}
  fi
}

# Sets the tab and window titles with the command name.
function set-title-by-command {
  emulate -L zsh
  setopt LOCAL_OPTIONS EXTENDED_GLOB

  # Get the command name that is under job control.
  if [[ "${1[(w)1]}" == (fg|%*)(\;|) ]]; then
    # Get the job name, and, if missing, set it to the default %+.
    local job_name="${${1[(wr)%*(\;|)]}:-%+}"

    # Make a local copy for use in the subshell.
    local -A jobtexts_from_parent_shell
    jobtexts_from_parent_shell=(${(kv)jobtexts})

    jobs $job_name 2>/dev/null > >(
      read index discarded
      # The index is already surrounded by brackets: [1].
      set-title-by-command "${(e):-\$jobtexts_from_parent_shell$index}"
    )
  else
    # Set the command name, or in the case of sudo or ssh, the next command.
    local cmd=${1[(wr)^(*=*|sudo|ssh|-*)]}

    # Right-truncate the command name to 15 characters.
    if (( $#cmd > 15 )); then
      cmd="${cmd[1,15]}..."
    fi

    set-window-title "$SSHHOST$cmd"
    for kind in tab screen; do
      set-${kind}-title "$cmd"
    done
  fi
}

# Don't override precmd/preexec; append to hook array.
autoload -Uz add-zsh-hook

# Sets the tab and window titles before the prompt is displayed.
function set-title-precmd {
  if zstyle -t ':dotzsh:module:terminal' auto-title; then
    if [[ "$TERM_PROGRAM" == 'Apple_Terminal' ]]; then
      # Set the current working directory in Apple Terminal.
      printf '\e]7;%s\a' "file://$HOST${PWD// /%20}"
    fi

    if [[ ! -z $SSH_CONNECTION ]]; then
      SSHHOST="$HOSTNAME:"
      if [[ "$TERM" == ((x|a|ml|dt|E)term*|(u|)rxvt*) ]]; then
        tab_$_prompt_host
      fi
    else
      tab_reset
    fi

    set-window-title "$SSHHOST${(%):-%~}"
    for kind in tab screen; do
      # Left-truncate the current working directory to 15 characters.
      set-${kind}-title "$SSHHOST${(%):-%15<...<%~%<<}"
    done
  fi
}
add-zsh-hook precmd set-title-precmd

# Sets the tab and window titles before command execution.
function set-title-preexec {
  if zstyle -t ':dotzsh:module:terminal' auto-title; then
    if [[ "$TERM_PROGRAM" != 'Apple_Terminal' ]]; then
      set-title-by-command "$SSHHOST$2"
    fi
  fi
}
add-zsh-hook preexec set-title-preexec

function tab_red()     { tab_color 172  65  66; }
function tab_orange()  { tab_color 210 132  69; }
function tab_yellow()  { tab_color 244 191 117; }
function tab_green()   { tab_color 144 169  89; }
function tab_cyan()    { tab_color 117 181 170; }
function tab_blue()    { tab_color 106 159 181; }
function tab_magenta() { tab_color 170 117 159; }
function tab_brcyan()  { tab_color 143  85  54; }

function tab_color() {
  echo -n -e "\033]6;1;bg;red;brightness;$1\a"
  echo -n -e "\033]6;1;bg;green;brightness;$2\a"
  echo -n -e "\033]6;1;bg;blue;brightness;$3\a"
}

tab_reset() { echo -ne "\033]6;1;bg;*;default\a" }

[[ "$TERM_PROGRAM" != "" ]] && export LC_TERM_PROGRAM="$TERM_PROGRAM"
[[ "$ITERM_PROFILE" != "" ]] && export LC_TERM_PROFILE="$ITERM_PROFILE"
[[ "$ITERM_PROFILE" = "Hotkey Window" ]] && export LC_TERM_PROFILE="base16-default.dark"


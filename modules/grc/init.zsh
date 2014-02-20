#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Setup grc, colourify anything
#
# Authors:
#   Ben O'Hara <bohara@gmail.com>
#

if (( ! $+commands[grc] )); then
  return 1
fi

if zstyle -t ':dotzsh:module:grc' color; then
  # Set the commands to wrap.
  zstyle -a ':dotzsh:module:grc' commands '_grc_cmds'
  if (( ${#_grc_cmds[@]} == 0 )); then
    _grc_cmds=(
      'cat' 'tail' 'configure' 'diff' 'make' 'gcc' 'g++' 'as' 'gas' 'ps'
      'ld' 'netstat' 'ping' 'ping6' 'traceroute' 'traceroute6' 'nmap' 'df'
      'mount' 'mtr' 'ifconfig' 'dig'
     )
  fi

  # Wrap commands in grc
  for _grc_cmd in "${_grc_cmds[@]}"; do
    if (( ${+commands[${_grc_cmd}]} )); then
      eval "
        function ${_grc_cmd} {
          "grc -es --colour=auto ${_grc_cmd}" "\$@"
        }
      "
    fi
  done
fi

unset _grc_cmd{s,}


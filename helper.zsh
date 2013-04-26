#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Defines helper functions.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Ben O'Hara <bohara@gmail.com>
#

# Checks a boolean variable for "true".
# Case insensitive: "1", "y", "yes", "t", "true", "o", and "on".
function is-true {
  [[ -n "$1" && "$1" == (1|[Yy]([Ee][Ss]|)|[Tt]([Rr][Uu][Ee]|)|[Oo]([Nn]|)) ]]
}

# Checks a name if it is a command, function, or alias.
function is-callable {
  (( $+commands[$1] )) || (( $+functions[$1] )) || (( $+aliases[$1] ))
}

# Prints the first non-empty string in the arguments array.
function coalesce {
  for arg in $argv; do
    print "$arg"
    return 0
  done
  return 1
}

# Checks if a file can be autoloaded by trying to load it in a subshell.
function autoloadable {
  ( unfunction $1 ; autoload -U +X $1 ) &> /dev/null
}

function format-elapsed {
  hours=$(($1 / 10000000000000 % 24))
  mins=$(($1 / 100000000000 % 60))
  secs=$(($1 / 1000000000 % 60))
  hsecs=$(($1 / 10000000 % 100))
  msecs=$(($1 / 1000000 % 1000))
  local elapsed
  if [[ $hours > 0 ]]; then
    elapsed+="$hours hours, $mins mins and $secs secs"
  elif [[ $mins > 0 ]]; then
    elapsed+="$mins mins and $secs secs"
  elif [[ $secs > 0 ]]; then
    if [[ $hsecs > 0 ]]; then
      elapsed+="$secs.$hsecs secs"
    else
      elapsed+="$secs secs"
    fi
  elif [[ $msecs > 0 ]]; then
    elapsed+="$msecs ms"
  else
    elapsed+="0"
  fi
  print $elapsed
}


# Loads dotzsh modules.
function dzmodload {
  local -a dzmodules
  local dzmodule
  local dzmodload_start
  local dzmodload_stop
  local dzmodload_elapsed
  local dzmodload_module_start
  local dzmodload_module_stop
  local dzmodload_module_elapsed
  local dzmodload_module_elapsed_total=0
  local type

  if zstyle -t ":dotzsh:load" timing && (( $+commands[gdate] )); then
    dzmodload_start=$(gdate +'%s%N')
  else
    dzmodload_start=0
  fi
  # $argv is overridden in the anonymous function.
  dzmodules=("$argv[@]")

  __() {
    # Extended globbing is needed for listing autoloadable function directories.
    setopt LOCAL_OPTIONS EXTENDED_GLOB

    # Add functions to fpath.
    fpath=(${DOTZSH}/modules/${^dzmodules}/functions(/FN) $fpath)
    fpath=(${DOTZSHLOCAL}/modules/${^dzmodules}/functions(/FN) $fpath)
    # Load dotzsh functions.
    for dzfunction in \
      $DOTZSH/modules/${^dzmodules}/functions/^([_.]*|README*)(.N:t) \
      $DOTZSH.local/modules/${^dzmodules}/functions/^([_.]*|README*)(.N:t)
    do
      autoload -Uz "$dzfunction"
    done
  } && __

  for dzmodule in "$dzmodules[@]"; do
    if zstyle -t ":dotzsh:module:${dzmodule}" timing && (( $+commands[gdate] )); then
      dzmodload_module_start=$(gdate +'%s%N')
    fi

    if zstyle -t ":dotzsh:module:local:${dzmodule}" loaded; then
      continue
    elif zstyle -t ":dotzsh:module:${dzmodule}" loaded; then
      continue
    elif [[ ! -d "${DOTZSHLOCAL}/modules/$dzmodule" ]]; then
      zstyle ":dotzsh:module:local:${dzmodule}" loaded 'no'
      if [[ ! -d "${DOTZSH}/modules/$dzmodule" ]]; then
        zstyle ":dotzsh:module:${dzmodule}" loaded 'no'
        continue 1
      elif [[ -s "${DOTZSH}/modules/$dzmodule/init.zsh" ]]; then
        source "${DOTZSH}/modules/$dzmodule/init.zsh"
      fi
      if (( $? == 0 )); then
        zstyle ":dotzsh:module:${dzmodule}" loaded 'yes'
        if zstyle -t ":dotzsh:module:${dzmodule}" aliases; then
          if [[ -s "${DOTZSH}/modules/${dzmodule}/aliases.zsh" ]]; then
            source "${DOTZSH}/modules/$dzmodule/aliases.zsh"
          fi
        fi
      else
        zstyle ":dotzsh:module:${dzmodule}" loaded 'no'
        for dzfunction in \
          $DOTZSH/modules/${^dzmodule}/functions/^([_.]*|README*)(.N:t)
        do
          if (( $+functions[$dzfunction] )); then
            unfunction "$dzfunction"
          fi
        done
        # remove the fpath entry
        fpath[(r)${DOTZSH}/modules/${dzmodule}/functions]=()
      fi
    elif [[ -s "${DOTZSHLOCAL}/modules/$dzmodule/init.zsh" ]]; then
      # try to source a local modules
      zstyle ":dotzsh:module:${dzmodule}" loaded 'no'
      source "${DOTZSHLOCAL}/modules/$dzmodule/init.zsh"
      if (( $? == 0 )); then
        zstyle ":dotzsh:module:local:${dzmodule}" loaded 'yes'
        if zstyle -t ":dotzsh:module:${dzmodule}" aliases; then
          if [[ -s "${DOTZSHLOCAL}/modules/${dzmodules}/aliases.zsh" ]]; then
            source "${DOTZSHLOCAL}/modules/$dzmodule/aliases.zsh"
          fi
        fi
      else
        zstyle ":dotzsh:module:local:${dzmodule}" loaded 'no'
        for dzfunction in \
          $DOTZSHLOCAL/modules/${^dzmodule}/functions/^([_.]*|README*)(.N:t)
        do
          if (( $+functions[$dzfunction] )); then
            unfunction "$dzfunction"
          fi
        done
        # remove the fpath entry
        fpath[(r)${DOTZSHLOCAL}/modules/${dzmodule}/functions]=()
      fi
    else
      zstyle ":dotzsh:module:${dzmodule}" loaded 'no'
      zstyle ":dotzsh:module:local:${dzmodule}" loaded 'no'
    fi

    if zstyle -t ":dotzsh:module:${dzmodule}" timing && (( $+commands[gdate] )); then
      let dzmodload_module_stop=$(gdate +'%s%N')
      (( dzmodload_module_elapsed = $dzmodload_module_stop - $dzmodload_module_start ))
      (( dzmodload_module_elapsed_total = $dzmodload_module_elapsed_total + $dzmodload_module_elapsed ))
    else
      dzmodload_module_elapsed=0
    fi
    zstyle ":dotzsh:module:${dzmodule}" elapsed ${dzmodload_module_elapsed}
    unset dzmodload_module_{start,stop,elapsed}
  done
  if zstyle -t ":dotzsh:load" timing && (( $+commands[gdate] )); then
    let dzmodload_stop=$(gdate +'%s%N')
    (( dzmodload_elapsed=$dzmodload_stop-$dzmodload_start ))
    zstyle ":dotzsh:module" elapsed ${dzmodload_module_elapsed_total}
  fi
  zstyle ":dotzsh:load" elapsed ${dzmodload_elapsed}

  unset dzmodule{s,} dzmodload_{module_,}{start,stop,elapsed}
}

function dzinfo {
  local -a dzmodules
  local dzmodule
  local dzmodload_elapsed
  local dzmodload_module_loaded
  local dzmodload_module_elapsed
  local dzmodload_module_elapsed_total
  local dzmodload_module_color
  local dzmodload_module_aliases

  zstyle -a ':dotzsh:load' dzmodule 'dzmodules'
  zstyle -a ":dotzsh:load" elapsed 'dzmodload_elapsed'
  zstyle -a ":dotzsh:module" elapsed 'dzmodload_module_elapsed_total'
  print >&1
  print -n "  dotzsh $DOTZSH_VERSION on $OSTYPE running zsh $ZSH_VERSION"  >&1
  print >&1
  print >&1
  if zstyle -t ":dotzsh:load" timing; then
    print " module                            global local   aliases colour  startup">&1
    print " ======                            ====== =====   ======= ======  =======">&1
  else
    print " module                            global local   aliases colour">&1
    print " ======                            ====== =====   ======= ======">&1
  fi
  for dzmodule in "$dzmodules[@]"; do
    zstyle -a ":dotzsh:module:$dzmodule" loaded 'dzmodload_module_loaded'
    zstyle -a ":dotzsh:module:local:$dzmodule" loaded 'dzmodload_local_module_loaded'
    zstyle -a ":dotzsh:module:$dzmodule" elapsed 'dzmodload_module_elapsed'
    zstyle -a ":dotzsh:module:$dzmodule" aliases 'dzmodload_module_aliases'
    zstyle -a ":dotzsh:module:$dzmodule" color 'dzmodload_module_color'

    if zstyle -t ":dotzsh:load" timing; then
      printf " %-35s %4s %-3s  %10s %-3s  %10s\n" \
        ${dzmodule} \
        ${dzmodload_module_loaded} \
        ${dzmodload_local_module_loaded} \
        ${dzmodload_module_aliases} \
        ${dzmodload_module_color} \
        "$(format-elapsed ${dzmodload_module_elapsed})" >&1
    else
      printf " %-35s %4s %-3s  %10s %-3s\n" \
        ${dzmodule} \
        ${dzmodload_module_loaded} \
        ${dzmodload_local_module_loaded} \
        ${dzmodload_module_aliases} \
        ${dzmodload_module_color} >&1
    fi
  done
  if zstyle -t ":dotzsh:load" timing; then
    print "                                                                  =======">&1
    printf "                                               modules Loaded in %8s\n" \
      "$(format-elapsed ${dzmodload_module_elapsed_total})" >&1
    printf "                                                dotzsh Loaded in %8s\n" \
      "$(format-elapsed ${dzmodload_elapsed})" >&1
  fi
  print >&1

  unset dzmodule{s,} dzmodload_module_{loaded,elapsed,color,aliases}

}

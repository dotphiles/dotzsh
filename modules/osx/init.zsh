#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Defines Mac OS X aliases and functions.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Ben O'Hara <bohara@gmail.com>
#

# This module is for Mac OS X only.
if [[ "$OSTYPE" != darwin* ]]; then
  return 1
fi

# Change directory to the current Finder directory.
alias cdf='cd "$(pfd)"'

# Push directory to the current Finder directory.
alias pushdf='pushd "$(pfd)"'

# Flush DNS cache
alias flushdns="dscacheutil -flushcache"
# Aggressively flush DNS cache
alias killdns="sudo killall -HUP mDNSResponder"

zstyle -b ':dotzsh:module:osx' launcher '_osx_launcher'
if is-true "${_osx_launcher}"; then
  app_dirs=(~/Applications /Applications /System/Library/CoreServices)
  for dir in $app_dirs
  do
    if [[ -d $dir ]]; then
      for app in $(find "$dir" -maxdepth 2 -iname "*.app" | tr ' ' '^')
      do
        app="$(echo "$app" | egrep -o '([^/]+)\.app')"
        app="${app%.app}"
        app_name="$(echo "$app" | tr '^' ' ')"
        app_command="$(echo "$app" | tr -d '^' | tr '[A-Z]' '[a-z]')"
        alias "$app_command"="open -a \"$app_name"\"
      done
    fi
  done
fi

if [[ -s /usr/bin/firefox ]] ; then
  unalias firefox
fi

# Open files in Quick Look.
function ql {
  (( $# > 0 )) && qlmanage -p "$@" &> /dev/null
}

# Delete .DS_Store and __MACOSX directories.
function rm-osx-cruft {
  find "${@:-$PWD}" \( \
    -type f -name '.DS_Store' -o \
    -type d -name '__MACOSX' \
  \) -print0 | xargs -0 rm -rf
}

# Tell the terminal about the working directory whenever it changes.
# This function is by Chris Page at http://superuser.com/a/328148
zstyle -b ':dotzsh:module:osx' terminal-resume '_terminal_resume'
if is-true "${_terminal_resume}"; then
  if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]] && [[ -z "$INSIDE_EMACS" ]]; then

      update_terminal_cwd() {
          # Identify the directory using a "file:" scheme URL, including
          # the host name to disambiguate local vs. remote paths.

          # Percent-encode the pathname.
          local URL_PATH=''
          {
              # Use LANG=C to process text byte-by-byte.
              local i ch hexch LANG=C
              for ((i = 1; i <= ${#PWD}; ++i)); do
                  ch="$PWD[i]"
                  if [[ "$ch" =~ [/._~A-Za-z0-9-] ]]; then
                      URL_PATH+="$ch"
                  else
                      hexch=$(printf "%02X" "'$ch")
                      URL_PATH+="%$hexch"
                  fi
              done
          }

          local PWD_URL="file://$HOST$URL_PATH"
          #echo "$PWD_URL"        # testing
          printf '\e]7;%s\a' "$PWD_URL"
      }

      # Register the function so it is called whenever the working
      # directory changes.
      autoload add-zsh-hook
      add-zsh-hook chpwd update_terminal_cwd

      # Tell the terminal about the initial directory.
      update_terminal_cwd
  fi
fi


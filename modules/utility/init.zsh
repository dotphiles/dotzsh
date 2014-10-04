#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Defines general aliases and functions.
#
# Authors:
#   Robby Russell <robby@planetargon.com>
#   Suraj N. Kurapati <sunaku@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Ben O'Hara <bohara@gmail.com>
#

# Load dependencies.
dzmodload 'spectrum'

# Correct commands.
setopt CORRECT
CORRECT_IGNORE='_*'

# Aliases

# Reload dotzsh
alias dzs='source ~/.zshrc && echo "Reloaded $HOME/.zshrc!"'
alias dzD='setopt XTRACE && echo "DEBUG ENABLED" && dzs'
alias dzd='unsetopt XTRACE && dzs'

# Disable correction.
for command in ack cd cp ebuild gcc gist grep heroku \
  ln man mkdir mv mysql rm scp
do
  if (( $+commands[$command] )); then
    alias $command="nocorrect ${command}"
  fi
done

# Disable globbing.
alias fc='noglob fc'
alias find='noglob find'
alias history='noglob history'
alias locate='noglob locate'
alias rake='noglob rake'

# Define general aliases.
alias _='sudo'
alias en='sudo -s'
alias __='sudo -s'
alias b='${(z)BROWSER}'
alias cp="${aliases[cp]:-cp} -i"
alias e='${(z)EDITOR}'
alias ln="${aliases[ln]:-ln} -i"
alias mkdir="${aliases[mkdir]:-mkdir} -p"
alias mv="${aliases[mv]:-mv} -i"
alias p='${(z)PAGER}'
alias po='popd'
alias pu='pushd'
alias rm="${aliases[rm]:-rm} -i"
alias type='type -a'

alias l='ls -1A'         # Lists in one column, hidden files.
alias ll='ls -lh'        # Lists human readable sizes.
alias lr='ll -R'         # Lists human readable sizes, recursively.
alias la='ll -A'         # Lists human readable sizes, hidden files.
alias lm='la | "$PAGER"' # Lists human readable sizes, hidden files through pager.
alias lx='ll -XB'        # Lists sorted by extension (GNU only).
alias lk='ll -Sr'        # Lists sorted by size, largest last.
alias lt='ll -tr'        # Lists sorted by date, most recent last.
alias lat='ll -atr'      # Lists sorted by date, hidden files, most recent last.
alias lc='lt -c'         # Lists sorted by date, most recent last, shows change time.
alias lu='lt -u'         # Lists sorted by date, most recent last, shows access time.
alias sl='ls'            # I often screw this up.

# Mac OS X Everywhere
if [[ "$OSTYPE" == darwin* ]]; then
  alias o='open'
  alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
else
  alias o='xdg-open'
  alias get='wget --continue --progress=bar --timestamping'

  if (( $+commands[xclip] )); then
    alias pbcopy='xclip -selection clipboard -in'
    alias pbpaste='xclip -selection clipboard -out'
  fi

  if (( $+commands[xsel] )); then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
  fi
fi

alias pbc='pbcopy'
alias pbp='pbpaste'

# Resource Usage
alias df='df -kh'
alias du='du -kh'

if (( $+commands[htop] )); then
  alias top=htop
else
  alias topc='top -o cpu'
  alias topm='top -o vsize'
fi

#### global aliases
# zsh buch s.82 (z.B. find / ... NE)
alias -g NE='2>|/dev/null'
alias -g NO='&>|/dev/null'

alias -g G='| grep -'
alias -g P='2>&1 | $PAGER'
alias -g L='| less'
alias -g M='| most'
alias -g C='| wc -l'

# Quick exit
alias x="exit"
alias q="exit"

# My IP
alias myip='curl ifconfig.me'
# IP addresses
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

### Functions

# Serves a directory via HTTP.
function http-serve {
  local port="${1:-8000}"
  sleep 1 && open "http://localhost:${port}/" &
  python -m SimpleHTTPServer ${port}
}

# Makes a directory and changes to it.
function mkdcd {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}

# Changes to a directory and lists its contents.
function cdls {
  builtin cd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Pushes an entry onto the directory stack and lists its contents.
function pushdls {
  builtin pushd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Pops an entry off the directory stack and lists its contents.
function popdls {
  builtin popd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Prints columns 1 2 3 ... n.
function slit {
  awk "{ print ${(j:,:):-\$${^@}} }"
}

# Finds files and executes a command on them.
function find-exec {
  find . -type f -iname "*${1:-}*" -exec "${2:-file}" '{}' \;
}

# Displays user owned processes status.
function psu {
  ps -{U,u}" ${1:-$USER}" -o 'pid,%cpu,%mem,command' "${(@)argv[2,-1]}"
}

function encode64 {
  echo -n $1 | base64
}

function decode64 {
  echo -n $1 | base64 -d
}

function up {
  for parent in {1..${1:-1}}; do
    builtin cd ..
  done
}

function scratch {
  _scratch=$HOME/scratch
  if [[ "$1" == "" ]]; then
    echo -e "Usage: $0 \"name\"\n"
    echo -e "Existing scratch dirs:\n"
    echo -n "   "
    ls $_scratch/
    echo
  else
    _scratch=$_scratch/$1
    if [[ -d $_scratch ]]; then
      cd $_scratch
    else
      mkdir -p $_scratch
      cd $_scratch
    fi
  fi
  unset _scratch
}

function cdup()
{
    if [[ -z "$1" ]]; then
        cd ..
    else
        local -a cdpathtemp
        local integer depth=${#PWD//[^\/]/}
        for (( i = 1; i <= depth; i++ )); do
            cdpathtemp+=(${(l:(($i * 3 - 1))::../::..:)})
        done
        cdpath=($cdpathtemp) cd $1
    fi
    return $?
}

function grepp() {
  [ $# -eq 1 ] && perl -00ne "print if /$1/i" || perl -00ne "print if /$1/i" < "$2"
}

function pingrouter() {
  GATEWAY=`netstat -rn | grep "default" | awk '{print $2}'`; if [ $? != 0 ]; then echo "No internet gateways found"; exit 1; else ping $GATEWAY; fi
}

# repeat last command with sudo
function fuck() {
  LAST_CMD=`fc -nl -1`
  echo sudo $LAST_CMD
  sudo zsh -c $LAST_CMD
}

# clean up photos of a whiteboard
function whiteboard_clean() {
  convert "$1" -resize %50 -morphology Convolve DoG:15,100,0 -negate -normalize -blur 0x1 -channel RBG -level 60%,91%,0.1 "$2"
}

# ctrl+z to fg
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    fg
    zle redisplay
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

alias mmv="noglob zmv -W"

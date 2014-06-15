#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Load theme and setup prompt, dircolors etc
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Ben O'Hara <bohara@gmail.com>
#

# Try a host specific theme
zstyle -a ':dotzsh:module:theme:hostname:'$HOSTNAME theme '_theme_hostname_argv'
zstyle -a ':dotzsh:module:theme:domain:'$DOMAIN theme '_theme_domain_argv'
zstyle -a ':dotzsh:module:theme' theme '_theme_argv'

_theme='off'
if (( $#_theme_hostname_argv > 0 )); then
  _theme=($_theme_hostname_argv)
elif (( $#_theme_domain_argv > 0 )); then
  _theme=($_theme_domain_argv)
elif (( $#_theme_argv > 0 )); then
  _theme=($_theme_argv)
fi

fpath=(${DOTZSH}/themes/*/prompt(/FN) $fpath)
fpath=(${DOTZSHLOCAL}/themes/*/prompt(/FN) $fpath)

if [[ -e $DOTZSHLOCAL/themes/$_theme[1]/init.zsh ]]; then
  source $DOTZSHLOCAL/themes/$_theme[1]/init.zsh
  _theme_path="$DOTZSHLOCAL/themes/$_theme[1]/"
elif [[ -e $DOTZSH/themes/$_theme[1]/init.zsh ]]; then
  source $DOTZSH/themes/$_theme[1]/init.zsh
  _theme_path="$DOTZSH/themes/$_theme[1]/"
fi

# ls
if is-callable 'dircolors'; then
  # GNU Core Utilities
  zstyle -a ':dotzsh:module:theme:dircolors:'$_theme[1] theme '_theme_dircolors'
  if [[ `dircolors --version |head -1 |awk '{print $NF}'` > 8 ]]; then
    alias ls='ls --group-directories-first'
  else
    _theme_dircolors="$_theme_dircolors[1].old"
  fi

  if zstyle -t ':dotzsh:module:theme:ls' color; then
    zstyle -a ':dotzsh:module:theme:dircolors' theme '_dircolors'
    if (( ${#_dircolors} > 0 )) && [[ -s "$HOME/$_dircolors" ]]; then
      eval "$(dircolors "$HOME/$_dircolors")"
    elif (( ${#_theme_dircolors} > 0 )) && [[ -s "$_theme_path/$_theme_dircolors" ]]; then
      eval "$(dircolors "$_theme_path/$_theme_dircolors")"
    elif [[ -s "$HOME/.dir_colors" ]]; then
      eval "$(dircolors "$HOME/.dir_colors")"
    else
      eval "$(dircolors)"
    fi
    alias ls="${aliases[ls]:-ls} --color=auto"
  else
    alias ls="${aliases[ls]:-ls} -F"
  fi
else
  # BSD Core Utilities
  if zstyle -t ':dotzsh:module:theme:ls' color; then
    zstyle -a ':dotzsh:module:theme:lscolors' theme '_lscolors'
    zstyle -a ':dotzsh:module:theme:lscolors:'$_theme[1] theme '_theme_lscolors'
  if ((  ${#_lscolors} > 0 )); then
      export LSCOLORS="$_lscolors"
  elif (( ${#_theme_lscolors} > 0  )); then
      export LSCOLORS="$_theme_lscolors"
    else
      export LSCOLORS="exfxcxdxbxegedabagacad"
    fi
    alias ls="ls -G"
  else
    alias ls='ls -F'
  fi
fi

# Grep
if zstyle -t ':dotzsh:module:environment:grep' color; then
  zstyle -a ':dotzsh:module:theme:grepcolors' theme '_grepcolors'
  zstyle -a ':dotzsh:module:theme:grepcolors:'$_theme[1] theme '_theme_grepcolors'
  if ((  ${#_grepcolors} > 0 )); then
    export GREP_COLOR='$_grepcolors'
  elif (( ${#_theme_grepcolors} > 0  )); then
    export GREP_COLOR="$_theme_grepcolors"
  fi
  export GREP_OPTIONS='--color=auto'
fi

if zstyle -t ':dotzsh:module:completion' loaded; then
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
fi

# Load and execute the prompt theming system.
autoload -Uz promptinit && promptinit

prompt "$_theme[@]"

unset _theme_{hostname,domain,}argv _theme{_path,} {_theme,}_{ls,dir}colors


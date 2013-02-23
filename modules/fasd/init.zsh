#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Setup and use fasd
#
# Authors:
#   Ben O'Hara <bohara@gmail.com>
#

min_zsh_version='4.3.10'
if ! autoload -Uz is-at-least || ! is-at-least "$min_zsh_version"; then
  return 1
fi

if [[ -d ${0:h}/external/ ]]; then
  path=(${0:h}/external $path)
fi

if (( ! $+commands[fasd] )); then
  return 1
fi

cache_file="${0:h}/cache.zsh"

if [[ $commands[fasd] -nt "$cache_file" || ! -s "$cache_file"  ]]; then
  # Base init arguments
  init_args='posix-alias zsh-hook'

  # Load zsh-{ccomp,wcomp} when completion is loaded
  if zstyle -t ':dotzsh:module:completion' loaded; then
    init_args+=' zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install'
  fi

  # Cache init code
  fasd --init "${(z)init_args[@]}" >! "$cache_file" 2> /dev/null
fi

source "$cache_file"

unset cache_file init_args

alias j='z'                      # For autojump converts
alias v='f -t -e vim -b viminfo' # Quickly open files with vim.

for keymap in 'emacs' 'viins'; do
  bindkey -M "$keymap" "$key_info[Control]X$key_info[Control]A" fasd-complete    # C-x C-a (files and directories)
  bindkey -M "$keymap" "$key_info[Control]X$key_info[Control]D" fasd-complete-d  # C-x C-d (directories)
  bindkey -M "$keymap" "$key_info[Control]X$key_info[Control]F" fasd-complete-f  # C-x C-f (files)
done


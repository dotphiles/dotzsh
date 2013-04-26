#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Enables local Python package installation.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Sebastian Wiesner <lunaryorn@googlemail.com>
#   Ben O'Hara <bohara@gmail.com>
#

if (( ! $+commands[python] )); then
  return 1
fi

# Prepend PEP 370 per user site packages directory, which defaults to
# ~/Library/Python on Mac OS X and ~/.local elsewhere, to PATH/MANPATH.
if [[ "$OSTYPE" == darwin* ]]; then
  path=(/usr/local/share/python $HOME/Library/Python/*/bin(N) $path)
  manpath=($HOME/Library/Python/*/{,share/}man(N) $manpath)
else
  # This is subject to change.
  path=($HOME/.local/bin $path)
  manpath=($HOME/.local/{,share/}man(N) $manpath)
fi

# Load virtualenvwrapper into the shell session.
if [[ -z "$WORKON_HOME" ]] && (( $+commands[virtualenvwrapper_lazy.sh] )); then
  source "$commands[virtualenvwrapper_lazy.sh]"
fi

zstyle -a ':dotzsh:module:python' rcfile 'rcfile_argv'
if (( ${#rcfile_argv} > 0 )); then
  rcfile=$rcfile_argv
else
  rcfile="$HOME/.pythonrc"
fi
# Use pythonrc if it exists
if [[ -e "${rcfile}" ]]; then
  export PYTHONSTARTUP="${rcfile}"
fi


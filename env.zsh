#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Defines environment variables.
#
# Authors:
#   Ben O'Hara <bohara@gmail.com>
#

export DOTZSH_VERSION=$(head -1 "$DOTZSH/.dotzsh")

# Paths
typeset -gU cdpath fpath mailpath manpath path
typeset -gUT INFOPATH infopath

# Set the the list of directories that cd searches.
cdpath=(
  $cdpath
)

# Set the list of directories that info searches for manuals.
infopath=(
  /usr/local/share/info
  /usr/share/info
  $infopath
)

# Set the list of directories that man searches for manuals.
manpath=(
  /usr/local/share/man
  /usr/share/man
  $manpath
)

for path_file in /etc/manpaths.d/*(.N); do
  manpath+=($(<$path_file))
done
unset path_file

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  /usr/{bin,sbin}
  /{bin,sbin}
  ~/bin
  $path
)

for path_file in /etc/paths.d/*(.N); do
  path+=($(<$path_file))
done
unset path_file

# MacOSX
if [[ "$OSTYPE" = darwin*  && -d /opt/local ]]; then
  infopath=(
    /opt/local/share/info
    $infopath
  )
  manpath=(
    /opt/local/share/man
    $manpath
  )
  path=(
    /opt/local/{bin,sbin}
    $path
  )
fi

# Solaris
if [[ "$OSTYPE" = solaris* ]]; then
  infopath=(
    /usr/gnu/share/info
    $infopath
  )
  manpath=(
    /usr/gnu/share/man
    $manpath
  )
  path=(
    /usr/gnu/bin
    $path
  )
fi

# Language
if [[ -z "$LANG" ]]; then
  eval "$(locale)"
fi

# Browser (Default)
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi


#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Maintains a frequently used directory list for fast directory changes.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Ben O'Hara <bohara@gmail.com>
#

min_zsh_version='4.3.10'
if ! autoload -Uz is-at-least || ! is-at-least "$min_zsh_version"; then
  return 1
fi

_z_prefixes=(
  ''
  '/usr/local'
  '/opt/local'
  "$(brew --prefix 2> /dev/null)"
)

for _z_prefix in "$_z_prefixes[@]"; do
  _z_sh="${_z_prefix}/etc/profile.d/z.sh"

  if [[ -s "$_z_sh" ]]; then
    source "$_z_sh"
    break
  fi
done

unset _z_prefix{es,} _z_sh

if (( $+functions[_z] )); then
  function _z-precmd {
    _z --add "${PWD:A}"
  }

  autoload -Uz add-zsh-hook
  add-zsh-hook precmd _z-precmd

  alias z='nocorrect _z'
  alias j='nocorrect _z'
fi


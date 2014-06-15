#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Integrates autoenv into dotzsh.
#
# Authors:
#   Ben O'Hara <bohara@gmail.com>
#

if [[ -s "${0:h}/external/activate.sh" ]]; then
  source "${0:h}/external/activate.sh"
else
  return 1
fi


grc
===

Setup [grc][1] to colour output of various commands

Settings
--------

### Commands

To colourify a different set of commands, add the following to *zshrc*:

    zstyle ':dotzsh:module:grc' commands \
      'command1' \
      'command2' \
      'command3' \
      'command4'

By default the following commands are colourified, if available

   - `cat`
   - `tail`
   - `configure`
   - `diff`
   - `make`
   - `gcc`
   - `g++`
   - `as`
   - `gas`
   - `ps`
   - `ld`
   - `netstat`
   - `ping`
   - `ping6`
   - `traceroute`
   - `traceroute6`
   - `nmap`

Authors
-------

*The authors of this module should be contacted via the [issue tracker][2].*

  - [Ben O'Hara](https://github.com/benohara)

[1]: http://korpus.juls.savba.sk/~garabik/software/grc.html
[2]: https://github.com/dotphiles/dotzsh/issues


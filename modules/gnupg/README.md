GNUPG
=====

Provides for an easier use of [gnupg][1] and [gpg-agent][2].

Settings
--------

### SSH-Agent Protocol Emulation

To enable ssh-agent protocol emulation, add the following line to *zshrc*:

    zstyle ':dotzsh:module:gnupg' agent-ssh-support 'yes'

Aliases
-------

  - `gpgas` export as asci armoured
  - `gpgh` gpg help
  - `gpgks` seach keyserver for a users keys
  - `gpgl` list keys, with fingerprints
  - `gpgkS` sign a key
  - `gpgls` list signatures
  - `gpgen` encrypt a file
  - `gpgde` decrypt a file
  - `gpgrk` recieve keys from a keyserver
  - `gpgcl` clear sign
  - `gpgfp` show fingerprint
  - `gpgsk` send keys to keyserver

Authors
-------

*The authors of this module should be contacted via the [issue tracker][3].*

  - [Florian Walch](https://github.com/fwalch)
  - [Sorin Ionescu](https://github.com/sorin-ionescu)
  - [Ben O'Hara](https://github.com/benohara)

[1]: http://www.gnupg.org
[1]: http://linux.die.net/man/1/gpg-agent
[2]: https://github.com/dotphiles/dotzsh/issues


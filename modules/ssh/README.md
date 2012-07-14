SSH
===

Provides for an easier use of [openssh][1] and [ssh-agent][2]

This module should be loaded *after* the *completion* module if using aliases.

Settings
--------

### Agent Forwarding

To enable ssh-agent forwarding, add the following line to *zshrc*:

    zstyle ':dotzsh:module:ssh:agent' forwarding 'yes'

### Identities

To load multiple identities, add the following line to *zshrc*:

    zstyle ':dotzsh:module:ssh:agent' identities 'id_rsa' 'id_rsa2' 'id_github'

### Host Aliases

To add aliases for know hosts, add the following to to *zshrc*

    zstyle ':dotzsh:module:ssh:aliases' hosts 'yes'

Aliases will be created for known hostnames (from completion)

  - `hostname` ssh to hostname.

Aliases
-------

  - `ssh1` forces ssh to try protocol version 1 only
  - `ssh2` forces ssh to try protocol version 2 only
  - `ssh4` forces ssh to use IPv4 addresses only
  - `ssh6` forces ssh to use IPv6 addresses only
  - `sshA` enables forwarding of the authentication agent connection
  - `sshC` compress data
  - `sshD` specify a dynamic port forwarding
  - `sshF` specify alternate config file
  - `sshI` specify smartcard device
  - `sshL` specify local port forwarding
  - `sshM` master mode for connection sharing
  - `sshN` do not execute a remote command. (protocol version 2 only)
  - `sshO` multiplex control command
  - `sshP` use non privileged port
  - `sshR` specify remote port forwarding
  - `sshS` path to control socket
  - `sshT` disable pseudo-tty allocation (protocol version 2 only)
  - `sshV` show version number
  - `sshX` enable (untrusted) X11 forwarding
  - `sshY` enable trusted X11 forwarding
  - `ssha` disable forwarding of authentication agent connection
  - `sshb` specify interface to transmit on
  - `sshc` select encryption cipher
  - `sshe` set escape character
  - `sshf` go to background
  - `sshg` allow remote hosts to connect to local forwarded ports
  - `sshi` select identity file
  - `sshk` disable forwarding of kerberos tickets
  - `sshl` specify login name
  - `sshm` specify mac algorithms
  - `sshn` redirect stdin from /dev/null
  - `ssho` specify extra options
  - `sshp` specify port on remote host
  - `sshq` quiet operation
  - `sshs` invoke subsystem
  - `ssht` force pseudo-tty allocation
  - `sshv` verbose mode
  - `sshx` disable X11 forwarding

Functions
---------

### General

  - `sshcd host dir` ssh to a host and change to a dir

Authors
-------

*The authors of this module should be contacted via the [issue tracker][3].*

  - [Robby Russell](https://github.com/robbyrussell)
  - [Theodore Robert Campbell Jr](https://github.com/trcjr)
  - [Joseph M. Reagle Jr.](https://github.com/reagle)
  - [Florent Thoumie](https://github.com/flz)
  - [Jonas Pfenniger](https://github.com/zimbatm)
  - [Gareth Owen](https://github.com/gwjo)
  - [Sorin Ionescu](https://github.com/sorin-ionescu)
  - [Ben O'Hara](https:/github.com/benohara)

[1]: http://openssh.org
[2]: http://www.openbsd.org/cgi-bin/man.cgi?query=ssh-agent&sektion=1
[3]: https://github.com/dotphiles/dotzsh/issues


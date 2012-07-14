Notify
======

Notify when long running commands finish using [growl][1]

Settings
--------

To change the required elapsed time, add the following to *zshrc*,
and replace **secs** with the number of seconds a command must run
before notifying (default 30).

    zstyle ':dotzsh:module:notify' elapsed 'secs'

Authors
-------

*The authors of this module should be contacted via the [issue tracker][2].*

  - [Ben O'Hara](https://github.com/benohara)

[1]: http://growl.info
[2]: https://github.com/dotphiles/dotzsh/issues


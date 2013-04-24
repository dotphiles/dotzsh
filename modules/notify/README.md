Notify
======

Notify when long running commands finish using [growl][1] or
[terminal-notifier][2].

Settings
--------

To change the required elapsed time, add the following to *zshrc*,
and replace **secs** with the number of seconds a command must run
before notifying (default 30).

    zstyle ':dotzsh:module:notify' elapsed 'secs'

To be notified only if the active window when the command finishes is
not the same window that started it add this to *zshrc*.

    zstyle ':dotzsh:module:notify' different-window-only 'yes'

Note that this uses AppleScript, which means it may cause overhead and
that your terminal must support AppleScript (Terminal.app and iTerm do).
Also, this only checks the window, not the tab, so if you are in a
different tab of the same terminal window, you won't be notified.

Authors
-------

*The authors of this module should be contacted via the [issue tracker][3].*

  - [Ben O'Hara](https://github.com/benohara)

[1]: http://growl.info
[2]: https://github.com/alloy/terminal-notifier
[3]: https://github.com/dotphiles/dotzsh/issues


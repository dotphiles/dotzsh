OSX
===

Defines [Mac OS X][1] aliases and functions.

Settings
--------

To alias all your applications, add the following to *zshrc*

    zstyle ':dotzsh:module:osx' launcher 'yes'

To make Terminal.app correctly resume open tabs to the same directory and to
make new tabs open in the same directory add this to your *zshrc*

    zstyle ':dotzsh:module:osx' terminal-resume 'yes'

Aliases
-------

  - `cdf` changes the current working director to the current _Finder_
    directory.
  - `pushdf` pushes the current working directory onto the directory queue and
  - `ql` quick looks at files.
  - `rm-osx-cruft` deletes .DS\_Store, \_\_MACOSX cruft.

Functions
---------

  - `manb` opens _man_ pages in [_Bwana.app_][2].
  - `manp` opens _man_ pages in _Preview.app_.
  - `pfd` prints the current _Finder_ directory.
  - `pfs` prints the current _Finder_ selection.
  - `tab` creates a new tab (works in both _Terminal_ and [_iTerm_][3]).
  - `trash` moves files and folders to _Trash_.

Authors
-------

*The authors of this module should be contacted via the [issue tracker][4].*

  - [Sorin Ionescu](https://github.com/sorin-ionescu)

[1]: http://www.apple.com/macosx/
[2]: http://bruji.com/bwana/
[3]: http://www.iterm2.com/
[4]: https://github.com/dotphiles/dotzsh/issues


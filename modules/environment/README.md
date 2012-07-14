Environment
===========

Sets general shell options and defines environment variables.

This module must be loaded first.

Settings
--------

### Pager

To select which editor is used, add the following to *zshrc*, and replace 'map' with
'less' or 'more'

    zstyle ':dotzsh:module:environment' pager 'map'

### Less mouse scrolling

To enable mouse scrolling in less, add the following to *zshrc*

    zstyle ':dotzsh:module:environment:pager:less' mousescroll 'true'

Environment Variables
---------------------

Contributors
------------

This module **MUST NOT** rely on any command not built in Zsh.

Non-interactive environment variables should be defined in *zshenv*.

Authors
-------

*The authors of this module should be contacted via the [issue tracker][1].*

  - [Sorin Ionescu](https://github.com/sorin-ionescu)

[1]: https://github.com/dotphiles/dotzsh/issues


GNU Utility
===========

Provides for the interactive use of GNU utilities on non-GNU systems.

Installing GNU utilities on non-GNU systems in `$PATH` without a prefix, i.e.
`ls` instead of `gls`, is not recommended since scripts that target other
utilities will be broken.

However, for interactive use, prefixed commands can be wrapped in their
non-prefixed counterparts.

This module must be loaded **before** the *utility* module.

Settings
--------

### Prefix

To use a different prefix, add the following to *zshrc*, and replace 'g' with
the desired prefix:

    zstyle ':dotzsh:module:gnu-utility' prefix 'g'

### Commands

To prefix a different set of commands, add the following to *zshrc*:

    zstyle ':dotzsh:module:gnu-utility' commands \
      'command1' \
      'command2' \
      'command3' \
      'command4'

  *This will over ride the default list of commands*

Authors
-------

*The authors of this module should be contacted via the [issue tracker][1].*

  - [Sorin Ionescu](https://github.com/sorin-ionescu)

[1]: https://github.com/dotphiles/dotzsh/issues


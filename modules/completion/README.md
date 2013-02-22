Completion
==========

Loads and configures tab completion and provides additional completions from
the [zsh-completions][1] project.

This module must be loaded **after** the *utility* module.

Settings
--------
### Case Sensitivity

To enable case-sensitivity for this module only, add the following line to
*zshrc*:

    zstyle ':dotzsh:module:completion' case-sensitive 'yes'

### Expand Global Aliases

To auto expand global aliases as they are typed, add the following line to
*zshrc*

    zstyle ':dotzsh:module:completion' expand-global-aliases 'yes'

Contributors
------------

Completions should be submitted to the [zsh-completions][1] project according
to its rules and regulations. This module will be synchronized against it.

Authors
-------

*The authors of this module should be contacted via the [issue tracker][2].*

  - [Sorin Ionescu](https://github.com/sorin-ionescu)

[1]: https://github.com/zsh-users/zsh-completions
[2]: https://github.com/dotphiles/dotzsh/issues


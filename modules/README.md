dotzsh modules
==============

Modules can be enabled for loading in *zshrc*.

dotzsh will try to load modules from

    $DOTZSHLOCAL/modules
    $DOTZSH/modules

Settings
--------

### Color

modules should disable all colors if the following is set

    zstyle ':dotzsh:module:modulename' colors 'no'

### Aliases

`aliases.zsh` wont be sourced if the following is set

    zstyle ':dotzsh:module:modulename' aliases 'no'

Packaging
---------

Modules for dotzsh should be bundled in the the following way

    module-name/init.zsh     <- Required, checks for required commands
    module-name/aliases.zsh  <- Optional, sets up aliases
    module-name/functions/   <- Optional, will be added to fpath
    module-name/external/    <- Optional, external resources

Available Modules
-----------------

  - `archive` - Provides functions to extract and list popular archive formats.
  - `command-not-found` - Loads the command-not-found tool on Debian-based distributions.
  - `completion` - Loads and configures tab completion and provides additional completions from
    the zsh-completions project.
  - `directory` - Sets directory options and defines directory aliases.
  - `dpkg` - Defines dpkg aliases and functions.
  - `environment` - Sets general shell options and defines environment variables.
  - `fasd` - Maintains a frequently used file and directory list for fast access.
  - `gnu-utility` - Provides for the interactive use of GNU utilities on non-GNU systems.
  - `gnupg` - Provides for an easier use of gpg-agent.
  - `haskell` - Enables local Haskell package installation.
  - `history-substring-search` - Integrates zsh-history-substring-search into Prezto.
  - `history` - Sets history options and defines history aliases.
  - `macports` - Defines MacPorts aliases and adds MacPorts directories to path variables.
  - `node` - Provides utility functions for Node.js and loads npm completion.
  - `osx` - Defines Mac OS X aliases and functions.
  - `pacman` - Provides aliases and functions for the Pacman package manager and frontends.
  - `perl` - Enables local Perl module installation on Mac OS X and defines aliases.
  - `python` - Enables local Python and local Python package installation.
  - `rails` - Defines Ruby on Rails aliases.
  - `rsync` - Defines rsync aliases.
  - `ruby` - Configures Ruby local gem installation, loads version managers, and defines
    aliases.
  - `screen` - Defines GNU Screen aliases and provides for auto launching it at start-up.
  - `ssh` - Provides for an easier use of ssh-agent.
  - `syntax-highlighting` - Integrates zsh-syntax-highlighting into Prezto.
  - `terminal` - Sets terminal window and tab titles.
  - `tmux` - Defines tmux aliases and provides for auto launching it at start-up.
  - `utility` - Defines general aliases and functions.
  - `wakeonlan` - This module provides a wrapper around the wakeonlan tool.
  - `yum` - Defines yum aliases.


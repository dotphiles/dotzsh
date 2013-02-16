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

Archive
-------

Provides functions to extract and list popular archive formats.

Command-Not-Found
-----------------

Loads the command-not-found tool on Debian-based distributions.

Completion
----------

Loads and configures tab completion and provides additional completions from
the zsh-completions project.

Directory
---------

Sets directory options and defines directory aliases.

Dpkg
----

Defines dpkg aliases and functions.

Environment
-----------

Sets general shell options and defines environment variables.

Fasd
----

Maintains a frequently used file and directory list for fast access.

GNU Utility
-----------

Provides for the interactive use of GNU utilities on non-GNU systems.

GNUPG
-----

Provides for an easier use of gpg-agent.

Haskell
-------

Enables local Haskell package installation.

History Substring Search
------------------------

Integrates zsh-history-substring-search into Prezto.

History
-------

Sets history options and defines history aliases.

Macports
--------

Defines MacPorts aliases and adds MacPorts directories to path variables.

Node.js
-------

Provides utility functions for Node.js and loads npm completion.

OSX
---

Defines Mac OS X aliases and functions.

Pacman
------

Provides aliases and functions for the Pacman package manager and frontends.

Perl
----

Enables local Perl module installation on Mac OS X and defines alises.

Python
------

Enables local Python and local Python package installation.

Ruby on Rails
-------------

Defines Ruby on Rails aliases.

Rsync
-----

Defines rsync aliases.

Ruby
----

Configures Ruby local gem installation, loads version managers, and defines
aliases.

Screen
------

Defines GNU Screen aliases and provides for auto launching it at start-up.

SSH
---

Provides for an easier use of ssh-agent.

Syntax Highlighting
-------------------

Integrates zsh-syntax-highlighting into Prezto.

Terminal
--------

Sets terminal window and tab titles.

Tmux
----

Defines tmux aliases and provides for auto launching it at start-up.

Utility
-------

Defines general aliases and functions.

Wake-on-LAN
-----------

This module provides a wrapper around the wakeonlan tool.

Yum
---

Defines yum aliases.



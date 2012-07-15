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


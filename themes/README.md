dotzsh themes
=============

Themes for dotzsh consist of a prompt setup function and an
optional init.zsh that can setup color values for the theme module
to load.

Packaging
---------

Themes for dotzsh should be bundled in the the following way

    theme-name/README.md    <- Required, README, explaining theme
    theme-name/init.zsh     <- Optional, set dircolors, lscolors etc
    theme-name/prompt/      <- Will be added to fpath
    theme-name/dircolors/   <- Optional, dircolors files for themes
    theme-name/screenshots/ <- Required, screenshots of theme


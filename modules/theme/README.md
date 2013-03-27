Theme
=====

Loads prompt [themes][1] and setup dircolors

Settings
--------

### Default theme

To select a default prompt theme, add the following to *zshrc*, and replace **name**
with the name of the theme you wish to load. Setting it to **random** will load
a random theme.

    zstyle ':dotzsh:module:theme' theme 'name'

### Custom Themes

To set a custom theme on a per host or per domain basis, add the following
to *zshrc* and replace **name** with the name of the theme you wish to load.

    zstyle ':dotzsh:module:theme:hostname:host1.example.com' theme 'name'
    zstyle ':dotzsh:module:theme:hostname:host2.example.com' theme 'name'
    zstyle ':dotzsh:module:theme:domain:example.net' theme 'name'

### Highlighting

If you have enabled color globally in *zshrc*, you may disable it for certain
commands.

To disable `ls` color, add the following line to *zshrc*; when coloring is
disabled, type indicators (\*, /, =>, @, =, |, %) will be appended to entries.

    zstyle ':dotzsh:module:theme:ls' color 'no'

To make `dir_colors` use a custom file, add the following line to *zshrc*:

    zstyle ':dotzsh:module:theme:dircolors' theme '.dir_colors/solarized-dark'

To use a custom `LSCOLORS` variable, add the following the *zshrc*

    zstyle ':dotzsh:module:theme:lscolors' theme '$LSCOLORS'

Authors
-------

*The authors of this module should be contacted via the [issue tracker][2].*

  - [Sorin Ionescu](https://github.com/sorin-ionescu)

[1]: http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#Prompt-Themes
[2]: https://github.com/dotphiles/dotzsh/issues


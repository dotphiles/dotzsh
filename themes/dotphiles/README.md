dotphiles theme
===============

Theme for dotzsh with vcs_info integration using the base16 color
scheme.

To enable, add the following to *zshrc*

    zstyle ':dotzsh:module:theme' theme 'dotphiles'

To use solarized light, use

    zstyle ':dotzsh:module:theme' theme 'dotphiles' 'base16-solarized.light'

Or for railscasts, use

    zstyle ':dotzsh:module:theme' theme 'dotphiles' 'base16-railscasts.dark'

To set the prompt color based on the host or domain name, use


    zstyle ':dotzsh:module:theme:hostname:your-host-here' theme 'dotphiles' 'base16-default.dark' 'magenta'
    zstyle ':dotzsh:module:theme:domain:your-domain-here' theme 'dotphiles' 'base16-default.dark' 'orange'

  ![screenshot 1][1]

[1]: https://raw.github.com/dotphiles/dotzsh/master/themes/dotphiles/screenshots/dotphiles.png "screenshot 1"


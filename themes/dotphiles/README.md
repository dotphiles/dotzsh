dotphiles theme
===============

Theme for dotzsh with vcs_info integration using the solarized color
scheme by default.

To enable, add the following to *zshrc*

    zstyle ':dotzsh:module:theme' theme 'dotphiles'

To use solarized light, use

    zstyle ':dotzsh:module:theme' theme 'dotphiles' 'sollight'

Or for zenburn, use

    zstyle ':dotzsh:module:theme' theme 'dotphiles' 'zenburn'

To set the prompt color based on the host or domain name, use


    zstyle ':dotzsh:module:theme:hostname:your-host-here' theme 'dotphiles' 'soldark' 'magenta'
    zstyle ':dotzsh:module:theme:domain:your-domain-here' theme 'dotphiles' 'zenburn' 'orange'

  ![screenshot 1][1]

[1]: https://raw.github.com/dotphiles/dotzsh/master/themes/dotphiles/screenshots/dotphiles.png "screenshot 1"


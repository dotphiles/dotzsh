dotzsh
======

dotzsh is a configuration framework for [Zsh][1] that enriches the command line
interface environment with sane defaults, aliases, functions, auto completion,
and prompt themes.

dotzsh strives to be platform and version independent, some functionality may be
lost when running under older versions of zsh, but it should degrade cleanly and
allow you to use the same setup on multiple machines of differing OS's without
problems.

Installation
------------

  1. Clone the repository:

        git clone --recursive https://github.com/dotphiles/dotzsh.git ~/.zsh

  2. Create a new Zsh configuration by copying the Zsh configuration file
     templates provided:

        for rcfile in ~/.zsh/templates/z{shenv,shrc,login,logout}; do
          cp -f $rcfile ~/.$rcfile:t
        done

  3. Set Zsh as your default shell:

        chsh -s /bin/zsh

  4. Open a new Zsh terminal window or tab.

### Mac OS X

If you have administrator privileges, you must fix an Apple-introduced problem
in Mac OS X 10.5 Leopard by executing the following command, or BASH and Zsh
will have the wrong `PATH` when executed non-interactively.

    sudo chmod ugo-x /usr/libexec/path_helper

`path_helper` is intended to make it easier for installers to add new paths to
the environment without having to edit shell configuration files by adding
a file with a path to the */etc/paths.d* directory.

Unfortunately, `path_helper` always reads paths from */etc/paths* set by Apple
then paths from */etc/paths.d* set by third party installers, and lastly paths
from the `PATH` environment variable set by the parent process, which
ultimately is set by the user with `export PATH=...` Thus, it reorders path
priorities, and user */bin* directories meant to override system */bin*
directories end up at the tail of the array.

### Troubleshooting

If you are not able to find certain commands after switching to *dotzsh*,
modify the `PATH` variable in *~/.zshenv* then open a new Zsh terminal
window or tab.

Usage
-----

dotzsh has many features disabled by default. Read the source code and
accompanying README files to learn of what is available.

### Modules

  1. Browse [~/.zsh/modules/][10] to see what is available.
  2. Load the modules you need in *~/.zshrc* then open a new Zsh terminal window
     or tab.

### Local Modules

  1. Add your own modules to *~/.zsh.local/modules/* to override existing modules.
  2. Load the modules you need in *~/.zshrc* then open a new Zsh terminal window
     or tab.

### Themes

  1. For a list of themes, type `prompt -l`.
  2. To preview a theme, type `prompt -p name`.
  3. Load the theme you like in *~/.zshrc* then open a new Zsh terminal window
     or tab.

### Troubleshooting

  To enable debug timing, add the following to *zshrc*

     zstyle ':dotzsh:load' timing 'yes'
     zstyle ':dotzsh:module:*' timing 'yes'

  `dzinfo` will show which module are loaded and how long they took to start.


      dotzsh 0.2.0 on darwin12.2.0 running zsh 5.0.0

     module                            global local   aliases colour  startup
     ======                            ====== =====   ======= ======  =======
     gnu-utility                          yes no          yes yes        5 ms
     environment                          yes no          yes yes        9 ms
     terminal                             yes no          yes yes        6 ms
     editor                               yes no          yes yes        7 ms
     history                              yes no          yes yes        3 ms
     utility                              yes no          yes yes       19 ms
     completion                           yes no          yes yes       29 ms
     directory                            yes no          yes yes        3 ms
     ssh                                  yes no          yes yes       34 ms
     gnupg                                yes no          yes yes       33 ms
     osx                                  yes no          yes yes        3 ms
     archive                              yes no          yes yes        2 ms
     git                                  yes no          yes yes        4 ms
     yum                                   no no          yes yes        3 ms
     tmux                                 yes no          yes yes        4 ms
     syntax-highlighting                  yes no          yes yes       14 ms
     perl                                 yes no          yes yes        7 ms
     rsync                                yes no          yes yes        7 ms
     grc                                  yes no          yes yes        3 ms
     node                                 yes no          yes yes        3 ms
     mercurial                            yes no          yes yes        3 ms
     notify                               yes no          yes yes        3 ms
     dotsync                              yes no          yes yes        6 ms
     fasd                                 yes no          yes yes       12 ms
     taskwarrior                          yes no          yes yes        2 ms
     history-substring-search             yes no          yes yes        6 ms
     theme                                yes no          yes yes       28 ms
                                                                      =======
                                                   modules Loaded in   273 ms
                                                    dotzsh Loaded in   359 ms

  `dzD` will enable ZTRACE and reload *zshrc*

  `dzd` will disable XTRACE and reload *zshrc*

  `dzs` will reload *zshrc*

Customization
-------------

The project is managed via [Git][3]. It is highly recommend that you commit
your changes and push them to [GitHub][4] to not lose them. If you do not know
how to use Git, follow this [tutorial][5] and bookmark this [reference][6].

### Completions

Submit program completions to the [zsh-completions][7] project. The dotzsh
completions directory will be synchronized against it.

### Resources

The [Zsh Reference Card][8] is indispensable.

Compatibility
-------------

dotzsh has been tested and developed to work on the following

  - MacOSX >= 10.6
  - Enterprise Linux >= 5
  - Debian >= 6
  - Ubuntu >= 11
  - ArchLinux >= 2011.08.19
  - OpenSolaris >= 11

If you use an older version or a different OS and see problems please raise an
issue on the [issue tracker][9]

License
-------

Copyright (c) 2012 [dotzsh contributers][11]

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[1]: http://www.zsh.org
[2]: https://raw.github.com/dotphiles/dotzsh/master/themes/dotphiles/screenshots/dotphiles.png "dotphiles theme"
[3]: http://git-scm.com
[4]: https://github.com
[5]: http://gitimmersion.com
[6]: http://gitref.org
[7]: https://github.com/zsh-users/zsh-completions
[8]: http://www.bash2zsh.com/zsh_refcard/refcard.pdf
[9]: https://github.com/dotphiles/dotzsh/issues
[10]: https://github.com/dotphiles/dotzsh/tree/master/modules
[11]: https://github.com/dotphiles/dotzsh/graphs/contributors


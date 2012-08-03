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

  1. Browse [~/.zsh/modules/][23] to see what is available.
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

  `dzinfo` will show which module are loaded and how long they took to start.

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

Contribute
----------

This project would not exist without all of its users and [contributors][24].

If you have ideas on how to make the configuration easier to maintain or
improve its performance, do not hesitate to fork and send pull requests.

If you want to contribute to the project, check out the list of open [issues][22]

You can:

 - raise an issue
 - suggest a feature

If you would like to contribute code to the project:

  1. A bit of background reading:
    - [Setting up Git for Windows and connecting to GitHub][11]
    - [The Simple Guide to Git][12]
    - [How to GitHub: Fork, Branch, Track, Squash and Pull Request][4]
    - [Write good commit messages][5].
  2. [Fork the repository][13]
  3. Make some changes to the code base
  4. [Send us a Pull Request once you're happy with it][14]

We'll do a bit of a code review before accepting your patch.

#### Modules

   - A *README.md* must be present.
   - Large functions must be placed in a *functions* directory.
   - Functions that take arguments must have completion.

#### Themes

   - A screenshots section must be present in the file header.
   - The pull request description must have must have [embedded
     screenshots][21].

  ![dotphiles theme][2]

### Git Flow

We use the Git Flow branching model, [first described][15] by [nvie][16],
so dotphiles's `master` branch moves on only at specific points, when we're
really sure we want to promote something to production.

**Use of Git Flow is not required for contributing to dotphiles**, particularly
if you're submitting a bug-fix or small feature.  Its use is recommended for
larger changes where `develop` might move on whilst you're completing your work.

#### Configuring Git Flow

There is a set of [helper scripts][17] that will work on both Unix-based
operating systems and Windows.  Follow the appropriate 
[installation instructions][18] for your operating system, and configure your
working copy repository for use with Git Flow by typing `git flow init`.
Accept all the default options to the questions that it asks you.

#### Using Git Flow

Pick a feature or bug to work on and create a new branch for that work by
typing `git flow feature start <featurename>`.  This will create you a new
*feature branch* for your work called `feature/<featurename>`, and you can use
git as usual from this point.

Once your feature is finished, type `git flow feature publish <featurename>`.
This will copy the *feature branch* to your `origin` repository on GitHub and
you will then be able to submit a pull request to have it merged into dotphiles
own `develop` branch.

**Note: do not use `git flow feature finish <featurename>`!**

This will automatically merge your *feature branch* back into `develop` and
delete the *feature branch*, making it harder for you to submit your pull
request.

If you wish to update your published feature branch after the initial publish,
use a regular `git push origin feature/<featurename>`.  This will also update
your pull request if you have one open for that branch.

If you find dotphiles `develop` branch has moved on, and you need/want to take
advantage of the changes made there, you can update your feature branch as
follows:

  1. Ensure you have a remote configured for the upstream repository.

       git remote add upstream git://github.com/dotphiles/dotphiles.git

  2. Update your local repository with the upstream refs.

        git pull upstream develop:develop`

  3. Rebase your feature branch on top of the new `develop`.

        git flow feature rebase <featurename>

There is a lot of help available for Git Flow, which can be accessed by typing
`git flow feature help`.

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
issue on the [issue tracker][22]

License
-------

Copyright (c) 2012 Ben O'Hara <bohara@gmail.com>

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
[9]: https://github.com/dotphiles/dotzsh/contributors
[10]: http://jeffkreeftmeijer.com/2010/why-arent-you-using-git-flow/
[11]: http://help.github.com/win-set-up-git/
[12]: http://rogerdudler.github.com/git-guide/
[13]: http://help.github.com/fork-a-repo/
[14]: http://help.github.com/send-pull-requests/
[15]: http://nvie.com/posts/a-successful-git-branching-model/
[16]: http://www.twitter.com/nvie
[17]: https://github.com/nvie/gitflow
[18]: https://github.com/nvie/gitflow/wiki/Installation
[19]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
[20]: https://help.github.com/articles/using-pull-requests
[21]: http://daringfireball.net/projects/markdown/syntax#img
[22]: https://github.com/dotphiles/dotzsh/issues
[23]: https://github.com/dotphiles/dotzsh/tree/master/modules
[24]: https://github.com/dotphiles/dotzsh/contributors


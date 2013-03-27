Contribute
----------

This project would not exist without all of its users and [contributors][14].

If you have ideas on how to make the configuration easier to maintain or
improve its performance, do not hesitate to fork and send pull requests.

If you want to contribute to the project, check out the list of open [issues][13]

You can:

 - raise an issue
 - suggest a feature

If you would like to contribute code to the project:

  1. A bit of background reading:
    - [Setting up Git for Windows and connecting to GitHub][2]
    - [The Simple Guide to Git][3]
    - [How to GitHub: Fork, Branch, Track, Squash and Pull Request][11]
    - [Write good commit messages][10].
  2. [Fork the repository][4]
  3. Make some changes to the code base
  4. [Send us a Pull Request once you're happy with it][5]

We'll do a bit of a code review before accepting your patch.

#### Modules

   - A *README.md* must be present.
   - Large functions must be placed in a *functions* directory.
   - Functions that take arguments must have completion.

#### Themes

   - A screenshots section must be present in the file header.
   - The pull request description must have must have [embedded
     screenshots][12].

  ![dotphiles theme][1]

### Git Flow

We use the Git Flow branching model, [first described][6] by [nvie][7],
so dotzsh's `master` branch moves on only at specific points, when we're
really sure we want to promote something to production.

**Use of Git Flow is not required for contributing to dotzsh**, particularly
if you're submitting a bug-fix or small feature.  Its use is recommended for
larger changes where `develop` might move on whilst you're completing your work.

#### Configuring Git Flow

There is a set of [helper scripts][8] that will work on both Unix-based
operating systems and Windows.  Follow the appropriate
[installation instructions][9] for your operating system, and configure your
working copy repository for use with Git Flow by typing `git flow init`.
Accept all the default options to the questions that it asks you.

#### Using Git Flow

Pick a feature or bug to work on and create a new branch for that work by
typing `git flow feature start <featurename>`.  This will create you a new
*feature branch* for your work called `feature/<featurename>`, and you can use
git as usual from this point.

Once your feature is finished, type `git flow feature publish <featurename>`.
This will copy the *feature branch* to your `origin` repository on GitHub and
you will then be able to submit a pull request to have it merged into dotzsh's
own `develop` branch.

**Note: do not use `git flow feature finish <featurename>`!**

This will automatically merge your *feature branch* back into `develop` and
delete the *feature branch*, making it harder for you to submit your pull
request.

If you wish to update your published feature branch after the initial publish,
use a regular `git push origin feature/<featurename>`.  This will also update
your pull request if you have one open for that branch.

If you find dotzsh's `develop` branch has moved on, and you need/want to take
advantage of the changes made there, you can update your feature branch as
follows:

  1. Ensure you have a remote configured for the upstream repository.

       git remote add upstream git://github.com/dotphiles/dotzsh.git

  2. Update your local repository with the upstream refs.

        git pull upstream develop:develop`

  3. Rebase your feature branch on top of the new `develop`.

        git flow feature rebase <featurename>

There is a lot of help available for Git Flow, which can be accessed by typing
`git flow feature help`.

[1]: https://raw.github.com/dotphiles/dotzsh/master/themes/dotphiles/screenshots/dotphiles.png "dotphiles theme"
[2]: http://help.github.com/win-set-up-git/
[3]: http://rogerdudler.github.com/git-guide/
[4]: http://help.github.com/fork-a-repo/
[5]: http://help.github.com/send-pull-requests/
[6]: http://nvie.com/posts/a-successful-git-branching-model/
[7]: http://www.twitter.com/nvie
[8]: https://github.com/nvie/gitflow
[9]: https://github.com/nvie/gitflow/wiki/Installation
[10]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
[11]: https://help.github.com/articles/using-pull-requests
[12]: http://daringfireball.net/projects/markdown/syntax#img
[13]: https://github.com/dotphiles/dotzsh/issues
[14]: https://github.com/dotphiles/dotzsh/contributors


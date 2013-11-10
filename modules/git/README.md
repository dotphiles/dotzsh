git
===

Module enhancing the [git][1] source control manager.

Automatically creates the `git` alias if [`hub`][2] is installed.

Settings
--------

### Aliases

To disable all aliases, add the following line to *zshrc*:

    zstyle ':dotzsh:module:git' aliases 'no'

Aliases
-------

### Git
 - `g`, The stupid content tracker

### Branch
 - `gb`, List, create, or delete branches
 - `gbc`, Create a new branch based at given commit
 - `gbl`, Show SHA1 and commit subject line for each head
 - `gbL`, Show SHA1 and commit subject line for each head (list both
remote-tracking branches and local branches)
 - `gbx`, Delete a fully merged branch
 - `gbX`, Delete a branch
 - `gbm`, Rename a branch and the corresponding reflog
 - `gbM`, Rename a branch even if the new branch-name already exists

### Commit
 - `gc`, Record changes to repository
 - `gca`, Stage all modified and deleted paths
 - `gcm`, Use the given message as the commit message
 - `gco`, Checkout branch or paths to working tree
 - `gcO`, Checkout paths to working tree (using `HEAD`)
 - `gcf`, Amend the tip of the current branch using the same log message as
`HEAD`
 - `gcp`, Apply changes introduced by some existing commits (fast forward, if
possible)
 - `gcP`, Apply changes introduced by some existing commits (do not make the
actual commit)
 - `gcr`, Revert existing commits
 - `gcR`, Revert current commit (`HEAD`)
 - `gcs`, Show various types of objects
 - `gcv`, Show dangling commits

### Data
 - `gd`, Information about files in index/working directory
 - `gdc`, Show cached files in output
 - `gdx`, Show deleted files in output
 - `gdm`, Show modified files in output
 - `gdu`, Show unmerged files in output
 - `gdk`, Show killed files in output
 - `gdi`, List ignored files

### Fetch
 - `gf`, Download objects and refs from another repository
 - `gfc`, Clone repository into new directory
 - `gfm`, Fetch from and merge with another repository or local branch
 - `gfr`, Fetch from and rebase on another repository or local branch

### Index
 - `gia`, Add file contents to index
 - `giA`, Add file contents to index (Interactively)
 - `giu`, Add file contents to index (update only files git already knows about)
 - `gid`, Show changes between index and named commit
 - `giD`, Show changes between index and named commit (Ignore white spaces)
 - `gir`, Reset current HEAD to specified state
 - `giR`, Reset current index to specified state
 - `gix`, Remove files/directories from the index (recursively)
 - `giX`, Remove files/directories from the index (recursively/forced)
 - `gig`, Print lines in the index matching a pattern

### Conflicts
 - `gkl`, List unmerged files
 - `gka`, Add every unmerged file
 - `gke`, Start merge-tool on every unmerged file
 - `gko`, Check out stage #2 for unmerged paths
 - `gkO`, Check out stage #2 for every unmerged paths
 - `gkt`, Check out stage #3 for unmerged paths
 - `gkT`, Check out stage #3 for every unmerged paths

### Log
 - `gl`, Show commit logs (display commits in topological order)
 - `gls`, Show commits diffstats
 - `gld`, Show commits full-diff
 - `glo`, Show commit logs (one line)
 - `glg`, Show commit logs (as a graph)
 - `glb`, Show commit logs (brief)
 - `glc`, Show commit short-logs

### Merge
 - `gm`, Join two or more development histories together
 - `gmC`, Perform the merge but do not commit the result
 - `gmF`, Generate a merge commit even if the merge resolved as a fast-forward
 - `gma`, Abort the current conflict resolution process, and try to reconstruct
the pre-merge state
 - `gmt`, Run merge conflict resolution tools to resolve merge conflicts

### Push
 - `gp`, Update remote refs along with associated objects
 - `gpf`, Force update remote refs along with associated objects
 - `gpa`, Update remote branches along with associated objects
 - `gpA`, Update every remote refs along with associated objects
 - `gpt`, Update remote tags along with associated objects
 - `gpc`, Add origin as an upstream reference for the current branch that is up
to date or pushed
 - `gpp`, Pull and push from origin to origin

### Rebase
 - `gr`, Fasforward-port local commits to the updated upstream head
 - `gra`, Abort current rebase
 - `grc`, Continue after resolving merge conflict
 - `gri`, Make a list of commits to be rebased and open in $EDITOR
 - `grs`, Skip the current patch

### Remote
 - `gR`, Manage set of tracked repositories
 - `gRl`, Show remote url after name
 - `gRa`, Add a new remote
 - `gRx`, Remove a remote and all associated tracking branches
 - `gRm`, Rename a remote and update all associated tracking branches
 - `gRu`, Fetch updates for a set of remotes
 - `gRc`, Delete all stale tracking branches for a remote
 - `gRs`, Show information about a given remote
 - `gRb`, Call the `git-hub` function

### Stash
 - `gs`, Stash away changes to dirty working directory
 - `gsa`, Apply the changes recorded in the stash
 - `gsc`, Remove all the stashed states
 - `gsx`, Remove a single stashed state from the stash list
 - `gsl`, List the stashes that you currently have
 - `gsL`, Show the diffstat of the last stash
 - `gsp`, Remove and apply a single stashed state from the stash list
 - `gss`, Save your local modifications to a new stash (and untracked)
 - `gsS`, Save your local modifications to a new stash (interactively)

### Submodule
 - `gS`, Initialize, update, or inspect submodules
 - `gSa`, Add given repository as a submodule
 - `gSf`, Evaluate shell command in each checked-out submodule
 - `gSi`, Initialize a submodule
 - `gSl`, Show the status of a submodule
 - `gSs`, Show commit summary between given commit and working tree/index
 - `gSu`, Update a submodule
 - `gSU`, Update or init a submodule (recursively)

### Working directory
 - `gws`, Show working-tree status (short format)
 - `gwS`, Show working-tree status
 - `gwd`, Show changes between commits, commit and working tree, etc.
 - `gwD`, Show changes between commits, commit and working tree, etc. (without white spaces)
 - `gwr`, Reset current HEAD to specified state, do not touch the index file nor
the working tree
 - `gwR`, Reset current HEAD to specified state,match the working tree and index
to the given tree
 - `gwc`, Remove untracked files from working tree (dry-run)
 - `gwC`, Remove untracked files and directories from working tree
 - `gwx`, Remove files from the working tree and from the index
 - `gwX`, Remove files from the working tree and from the index
 - `gwg`, Print lines matching a pattern

Functions
---------

### git-current-branch
Displays the current Git branch.

### git-hub
Opens a [GitHub][3] repository in the current `$BROWSER`.

### git-hub-short-url
Shortens GitHub URLs.

### git-info
Gets the Git status information.

### git-root
Displays the Git repository root.

Completion
----------

Adds the completion for `git`, `hub`, `git-hu` and `git-info`.

Settings
--------

### git prompt
The git module allows to create a custom prompt for git repositories. To do so,
each available information can be formatted separately then merged into `prompt`
and `rprompt`

#### Available informations
Each information has to be formatted before being inserted into the prompt.

The format is defined with a `zstyle` by providing the name of the element we
want to format, and the format.

    #zstyle ':dotzsh:module:git' Name 'Format code'
    zstyle ':dotzsh:module:git' branch 'Branch: %b'

Here is an exhaustive list of the elements and the format code that can be used:

<table>
  <tr><th>Name</th><th>Format code</th>
    <th>Content</th></tr>
  <tr><td>action</td><td>%s</td>
    <td>Special action name (am, merge, rebase).</td></tr>
  <tr><td>added</td><td>%a</td>
    <td>Indicator to notify of added files.</td></tr>
  <tr><td>ahead</td><td>%A</td>
    <td>Indicator to notify of ahead branch.</td></tr>
  <tr><td>branch</td><td>%b</td>
    <td>Branch name.</td></tr>
  <tr><td>behind</td><td>%B</td>
    <td>Indicator to notify of behind branch.</td></tr>
  <tr><td>commit</td><td>%c</td>
    <td>SHA-1 hash.</td></tr>
  <tr><td>deleted</td><td>%d</td>
    <td>Indicator to notify of deleted files.</td></tr>
  <tr><td>dirty</td><td>%D</td>
    <td>Indicator to notify of dirty files.</td></tr>
  <tr><td>modified</td><td>%m</td>
    <td>Indicator to notify of modified files.</td></tr>
  <tr><td>position</td><td>%p</td>
    <td>Current position in the git tree.</td></tr>
  <tr><td>renamed</td><td>%r</td>
    <td>Indicator to notify of renamed files.</td></tr>
  <tr><td>remote</td><td>%R</td
    ><td>Remote name.</td></tr>
  <tr><td>stashed</td><td>%S</td>
    <td>Indicator to notify of stashed files.</td></tr>
  <tr><td>untracked</td><td>%u</td>
    <td>Indicator to notify of untracked files.</td></tr>
  <tr><td>unmerged</td><td>%U</td>
    <td>Indicator to notify of unmerged files.</td></tr>
</table>

#### Prompt and rPrompt
Once every element has been pre-formated,
- prompt, Left prompt.
- rprompt, Right prompt.

#### Conditional formatting
It's possible to add some conditions.

#### Ignore submodule.
Getting the current git status from a project with submodules can take a long
time.

##### Enable the ignore mode
It's possible to ignore the submodule when it is 'dirty', 'untracked',
'all', or 'none':

    zstyle ':dotzsh:module:git:ignore' submodule ''

Authors
-------

*The authors of this module should be contacted via the [issue tracker][4].*

 - [Sorin Ionescu](/sorin-ionescu)
 - [Colin Hebert](/ColinHebert)

[1]: http://www.git-scm.com/
[2]: https://github.com/defunkt/hub
[3]: http://www.github.com
[4]: https://github.com/dotphiles/dotzsh

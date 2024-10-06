# Git Cheat Sheet

## Initialization and Cloning
```bash
git clone <url>                 # Clone a repository
git clone <url> <new-name>      # Clone with a new name

# Example:
git clone https://github.com/libgit2/libgit2 mylibgit
```

## Configuration
- **.gitconfig Locations:**
  - System: `/usr/local/git/etc/gitconfig`
  - Global: `$HOME/.gitconfig`
  - Local: `.git/config`
```bash
      ----------------------------------------------
      |  system /usr/local/git/etc/gitconfig       |
      |   --------------------------------------   |
      |   |  global $home/.gitconfig           |   |
      |   | ---------------------------------- |   |
      |   | |                                | |   | 
      |   | |  local .git/config             | |   |
      |   | |                                | |   |
      |   | ---------------------------------- |   |
      |   --------------------------------------   |
      ----------------------------------------------

```


```bash
git config --list                # List all configs
git config --list --local         # List local configs
git config --local edit           # Edit local config
git config --global edit          # Edit global config
```

## Status and Tracking
```bash
git status                       # Show the working tree status
```
- **Status Codes:**
  - `??` untracked files
  - `M` modified files
  - `A` new files added in staging area

## Ignoring Files
### .gitignore Examples
```gitignore
*.a                             # Ignore all .a files
!lib.a                          # Track lib.a
/TODO                           # Ignore only TODO in the root
build/                          # Ignore all files in build/
doc/*.txt                       # Ignore txt files in doc/
doc/**/*.pdf                    # Ignore all pdf files in doc/ and subdirs
```

## Staging Changes
```bash
git add <path>                  # Stage changes
git add --patch                 # Interactively choose hunks
git add --update                # Update tracked files
```

## Viewing Changes
```bash
git diff                                   # Show diff of modified files
git diff --staged                          # Show diff staged from last commit
git diff <oldHash>..<newHash>              # Show diff between two commits
git diff --no-index <file-one> <file-two>  # Show diff between two files
```

## Unstaging and Cleaning
```bash
git restore                     # Restore to last commit state
git restore --staged <path>     # Unstage files
git clean                       # Remove untracked files
```

## Commit History
```bash
git log                         # Show commit history
```
### Log Options:
- `--graph`: Show graph in logs
- `--patch`: Show diffs in logs
- `--oneline`: One-line commit messages
- Date filters: `--before`, `--after`
  ```
    --before="2020-09-29"
    --after="2020-09-29"
    --after="yesterday"
    --after="one week ago"
    --after="one month ago"
  ```
- Range log: `<oldHash>..<newHash>`
- File-specific log(if git cannot detec file): `-- <filename>`



**Note:** To show all commits if HEAD is detached:
```bash
git log --graph --oneline --all
```

## Branching
```bash
git branch                      # List all branches
git branch -m <oldname> <newname>  # Rename a branch

git switch <branch-name>        # Switch to another branch
git switch -C <branch-name>        # create new branch and switch to it 
```

## Merging
**Type**
  - fast forward
  - 3 way merge

```bash
git merge <branchname>          # Merge a branch
git merge --no-ff <branchname>  # Merge without fast-forward
```
```bash
--no-ff           --ff (default)
                           
* Merge 1           * Head 
| \                 |
|  @                @
|  |                |
|  @                @ 
|  |                | 
|  @ feature        @ feature 
| /                / 
*                  *
|                  |
*                  *
|                  |
* main             * main


```
- **Configure fast-forward behavior:**
```bash
git config ff no                # Disable fast-forward by default
git config --global ff no

git branch --merged              # Show merged branches
git branch --no-merged           # Show unmerged branches
git merge --abort                # Abort the merge
```

## Rebasing
**Video:** [Git Rebase](https://www.youtube.com/watch?v=qsTthZi23VE&t=1840s)

## Stashing Changes
```bash
git stash push -m "message"     # Stash changes with a message
git stash apply <index>         # Apply a stashed change
git stash list                  # List stashed changes
git stash drop <index>          # Drop a stashed change
git stash clear                 # Clear all stashes
```

## Cherry-Picking
```bash
git cherry-pick <hash>          # Apply a commit from another branch
```

## Tagging
```bash
git tag <hashcode>              # Create a lightweight tag
git tag <hashcode> -m "message" # Create an annotated tag

git tag -l <wildcard>           # List tags

git push origin <tag>           # Push a specific tag
git push origin --tags          # Push all tags

git tag -d <tag-name>           # Delete a local tag

git push origin --delete <tag-name> # Delete a remote tag
```

## Blame 
```bash
git blame <file-name>           # Show who changed each line in a file
git blame -L <line_No>,<line_No> <file-name>
git blame -L 11,22 main.js
```

## Bisect
```bash
git bisect                       # Use for binary search in commits
```
**Video:** [Git Bisect](https://youtu.be/z-AkSXDqodc?si=sLx0elyCX08g7KGm)

## Reflog
```bash
git reflog                      # View commit history for recovery
```

## Submodules
```bash
git submodule add <url>        # Add a submodule
git add .                      # Stage changes in the super project
git commit                     # Commit changes
```
**Video:** [Git Submodules](https://www.youtube.com/watch?v=gSlXo2iLBro&t=12s)

## Additional History Management
**Video:** [Git History Management](https://www.youtube.com/watch?v=ElRzTuYln0M&t=425s)

## Resetting Changes
```bash
git bash reset <filename/path>
```
- `--soft`: Reset HEAD but keep changes staged
- `--mixed`: Reset HEAD and keep changes unstaged
- `--hard`: Reset HEAD and discard all changes

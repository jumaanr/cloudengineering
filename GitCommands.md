## Git Documentation
Documentation: [https://git-scm.com/docs/](https://git-scm.com/docs/)

## Installation
```bash
sudo apt update
sudo apt install git -y
git --version
```

Installation on RPM based systems:
```bash
sudo dnf install git-all # or 
sudo yum install git-all
```

## Getting Help
```bash
git help # Get the help and command palette
git show # Show various types of objects
git help <command> # View additional help on each command
```

For this, you must install the git man pages using the following:
```bash
sudo apt-get install git-man
```

## Git Start-Up
```bash
git init # Init a Git Repository, this will create the .git directory structure
git status # Check the branches, commits, and untracked files
git add myFile.json # Stage a file for commit
git commit -m "Added first story" # Commit all staged files with a useful comment
git commit -am "My commit" # -a, --all option tells Git to automatically stage files that have been modified and deleted. New files are not affected.
```

Before committing, you need to introduce yourself to Git:
```bash
git config user.name "sarah" # Add a user for commit, so all commits are recorded in the name of the author
git config user.email "sarah@example.com" # Add user's email address who performs the commit
git config --global user.name "Jumaan Rimzy"
git config --global user.email "jumaanr@outlook.com"
git config --list # Shows the current values
git commit # Opens a text editor to provide a commit message
git add . # Stage all the files in the working area
git add *.txt # Pattern-based staging, where you add the txt files only
```

## Restore, Recover, and Remove
Use case: I want to restore my file to the state of a previous commit. How do I do it?

In older versions:
```bash
git checkout abc1234 -- myprogram.py # abc1234 is the commit hash, -- informs the following is a file name
```

In newer versions:
```bash
git restore --source=abc1234 myprogram.py # --source is the commit hash you are interested in
```

Even if you commit or stage a file, a copy will be saved, so you can restore the file:
```bash
git restore myFile.json # Discard the changes you have made in the working directory and restore it to the previous commit
git restore --staged myFile.json # Remove a file from the staging area
git rm notes.txt -f/--cached # Remove a tracked file from git tracking
```

To ignore a file permanently, add that file name to `.gitignore`:
```bash
echo "myFile.json" >> .gitignore
cat .gitignore
```

## Git Log - Checking Commit History
Information you get: commit hash, author, date, commit message

```bash
git log # Check the details of commit history
git log --oneline # Get a short description of commit history
git log --name-only # Get the list of changed files and their authors/modifiers
git log -n <number> # Get -n number of the latest records of commit history
git log --graph --decorate # See previous commit history along with the branch they were committed on
git log --all # Show all of the commits
git log origin/master # Check the log of the remote repository using the origin alias and branch master
```

Going back to a previous version/commit:
```bash
git checkout <commit_number> # The commit number can be obtained when you issue git log
```

## Git Branching
```bash
git branch newBranch # Create a new branch
git checkout newBranch # Switch branches
git checkout -b newBranch2 # Create a new branch and immediately switch to it
git branch -d newBranch2 # Delete a branch
git branch # List all the branches currently you have
git branch -l # List the branches
git branch -a # Show all branches including local and remote, current branch has *
```

## Git Merging a Branch
```bash
git checkout master # First, checkout to master branch
git merge feature/signup # Perform the merge
```

Squashing a branch:
What is squashing a branch?
```bash
git merge --squash FeatureA # Merge FeatureA branch to the current checked out branch. Squash merge will happen with minimum commits
```

## Working with Remote Repositories (GitHub)
GitHub, GitLab, and BitBucket are available.

Add a remote repo for a local project:
```bash
git remote add origin <Connection_String>
git remote add origin https://..../../[name].git
git remote -v # List all remote repositories
```

To fetch and push data to the hosted repo:
```bash
git remote show # Show remote repositories
git push origin master # git push <aliasOfRemoteRepo> <CurrentBranch/BranchName>
git clone http://git.example.com/sarah/story-blog # Clone a remote repository locally
git push -u origin master # Creates a link between local master and remote master branches
git push -u origin --all # Push changes of all branches to origin
git push -u origin main # Push changes only with the main branch
```

## Git Pull Request
When working in collaboration, directly pushing commits to the main branch is not advised. Instead, perform the commits in a sub-branch and then create a pull request.

Fetching and Pulling:
```bash
git fetch origin master # Update origin/master branch in our local repository
git merge origin/master # Now we have an updated local master
git branch -a # View all the branches both local and remote
```

Combined command:
```bash
git pull origin master # Fetch and merge remote changes directly into our local master branch
```

## Git Merge Conflicts
- When multiple people work on the same file, merge conflicts can occur.
- Git adds extra characters to the files that are conflicting.
- Edit and remove the content that does not need to be kept.
- Add the files to Git again and commit.
- The later branch can be merged with the master branch without any issues.

## Forking
Forking means creating an exact copy of a project to work on independently. Then once you think you are good to contribute, you make a pull request.

Steps:
1. Create a fork by clicking the 'Fork' button.
2. Clone the forked repository directly to your system.
3. Make changes (add, commit) and push the changes to the master branch of the forked repository.
4. Log in to GitUI and create a PR from the forked repo to the original repo.
5. Owners or admins will review and approve and merge the pull request.

## Rebasing
What is Git Rebasing? Changes from one branch are brought on top of another branch, rewriting the Git history.

```bash
git rebase master # Rebase your branch on top of the master branch
git rebase -i HEAD~4 # Interactively rebase last 4 commits
git cherry-pick b1fbc37 # Cherry-pick a certain commit and add it to your working branch
```

## Resetting and Reverting
What is resetting and reverting? How is it different from restoring?

Git Revert:
```bash
git revert 8ad5d # Reverse all changes made on a specific commit
git revert HEAD~0 # Revert the current/latest commit to the previous commit
```

Git Reset:
```bash
git reset --soft HEAD~1 # Revert the previous 1 commit back while keeping all the changes made
git status # We still have access to the changes made by the resetted commit
git reset --hard HEAD~1 # Reset last 1 commit without keeping changes made
git status # We cannot see the changes made in the previous commit
```

## Stashing
What is stashing in Git? Temporarily shelve changes made to your working directory to work on a different task.

```bash
git stash # Stash all the changes in the working area without commit
git stash pop # Get the changes back into the working area
git stash list # List all the stashes piled up
git stash show stash@{1} # See the content of a certain stash
git stash pop stash@{1} # Pop a specific stash instead of the last one
```

## Reflog
What is Reflogging in Git? A log that helps you recover your Git repository in case of deletion or disaster recovery.

```bash
git reflog # Shows all the actions that have been taken on the repo
git reset --hard 8ad5 # Recover using reflog
git log --graph # See the commits in the form of a graph
```

## Tagging in Git
What is tagging in Git?

```bash
git tag -a v1.0 -m "Version 1.0 release" # Tag the current commit you are on
git tag # Check all the tags placed in the current branch
git tag v1.0 # Shows the version already exists
```

## Miscellaneous
```bash
git show
git diff myfile # If there are changes, shows what has changed
```

# End of the Note
```

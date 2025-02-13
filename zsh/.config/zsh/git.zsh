# ================================================================================================
# git
# ================================================================================================
alias gb="git branch"
alias gs="git status"
alias ga="git add"
alias glo="git log --graph --oneline --decorate"
alias wt="git worktree"
alias gco="git checkout"
alias gsw="git switch"
alias gg="git pull"
alias gp="git push"
alias gpf="git push --force-with-lease"
alias gf="git fetch"
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gri='git rebase --interactive'
alias gmt='git mergetool'

# Pull the main or master branch for each submodule in a repo
# NOTE(aver): this is non-recursive, consider adding an option for recursive if necessary
function gsup() {
    git submodule foreach '
  if git show-ref --verify --quiet refs/heads/main; then
    git checkout main && git pull origin main;
  elif git show-ref --verify --quiet refs/heads/master; then
    git checkout master && git pull origin master;
  else
    echo "Neither main nor master branch exists in submodule at $sm_path";
  fi
'
}

# Lucas' .zshrc file.
# https://github.com/lucascosti/mac-config/zsh/

## Path to the dir containing my zsh scripts
export ZSH_SCRIPTS_DIR=~/repos/mac-config/zsh/zshscripts

## Source powerlevel10k & my theme
source $ZSH_SCRIPTS_DIR/powerlevel10k/powerlevel10k.zsh-theme
source $ZSH_SCRIPTS_DIR/themes/p10k-lucas.zsh

######## oh-my-zsh stuff  ########

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="/Users/lucascosti/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
## Lucas: not needed because powerlevel10k (see above) handles the theming.
#ZSH_THEME="lucas-theme"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git-auto-fetch)

source $ZSH/oh-my-zsh.sh

######## Lucas' custom stuff below here ########

# Load completions (e.g. for git completion)
autoload -Uz compinit && compinit
# allow commands to be executed in the prompt:
setopt PROMPT_SUBST
# allow comments in interactive shells (like Bash does)
setopt INTERACTIVE_COMMENTS
# Live life on the edge: like bash, don't prompt for confirmation when doing rm -rf *
setopt RM_STAR_SILENT
# set git autofetching to be once every 20 minutes
# https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/git-auto-fetch
GIT_AUTO_FETCH_INTERVAL=1200 #in seconds
# Disable highlighting of pasted text. See https://github.com/zsh-users/zsh/blob/ac0dcc9a63dc2a0edc62f8f1381b15b0b5ce5da3/NEWS#L37-L42
zle_highlight+=(paste:none)
# Bind Home/End keys for beginning/end of line.
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

# Set custom LSCOLORS for MacOS (see https://geoff.greer.fm/lscolors/)
# (on other Linux systems, it is the differently-formated LS_COLORS)
## OLD OSX default: Gxfxcxdxbxegedabagacad
## NEW:             Exfxcxdxcxegedabagacad
LSCOLORS='Exfxcxdxcxegedabagacad'
## LS_COLORS equivalent: 
LS_COLORS='di=1;34:ln=35:so=32:pi=33:ex=32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
# Set zsh's completion colors to use the above colors too (needs to use LS_COLORS):
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# This script enables syntax highlighting on the prompt (it must be sourced after all the other plugins/theme stuff above).
# https://github.com/zsh-users/zsh-syntax-highlighting
source $ZSH_SCRIPTS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
## Set the highlighters we want:
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
## Some custom highlighter colors:
### Declare the variable
typeset -A ZSH_HIGHLIGHT_STYLES
### Have paths colored blue instead of underlined (and a bit more vibrant blue than the ls one above):
ZSH_HIGHLIGHT_STYLES[path]='fg=33'

# Set path for the cheat command config (https://github.com/cheat/cheat)
export CHEAT_CONFIG_PATH="$ZSH_SCRIPTS_DIR/miscdotfiles/cheat/conf.yml"
# Cheat autocompletion:
_cmpl_cheat() {
  reply=($(cheat -l | cut -d' ' -f1))
}
compctl -K _cmpl_cheat cheat


# Aliases

## Regular aliases
### zsh sudo last command:
alias ffs='sudo $(fc -ln -1)'
alias bi='brew install'
alias br='brew uninstall'
alias bupd='brew update'
alias bupg='brew upgrade'
## Git aliases
alias g='git'
alias gfu='git fetch upstream'
alias gfo='git fetch origin'
alias gr='git rebase'
alias gpull='git pull'
alias gs='git status'
alias gc='git checkout'
alias gl="git log --pretty=format:'%Cblue%h%Creset%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)%an%Creset' --abbrev-commit --date=relative"
alias gbranches='git branch -a'
alias gnb='git checkout -b'
alias gnewbranch='git checkout -b'
alias grenamebranch='git branch -m'
alias grmbranch='git branch -d'
alias gd='git diff'
alias gss='git stash save'
alias gsp='git stash pop'
alias gsd='git stash drop'
alias gsl='git stash list'
alias ga='git add'
alias gaa='git add -A'
alias gcom='git commit'
alias gcomm='git commit -m'
alias gcomam='git add -A && git commit -m'
alias gcoma='git add -A && git commit'
alias gcommend='git add -A && git commit --amend --no-edit'
alias gm='git merge'
alias gcp='git cherry-pick'
alias gpoh='git push origin HEAD'
alias grom='git rebase origin/master'
alias gremotes='git remote -v'
alias gsub='git submodule'
alias gsubupd='git submodule update --remote --merge'
alias {cdr,cdg,gcd}='cd ~/repos/'
alias cdh='cd ~/repos/help-docs'
alias cdi='cd ~/repos/internal-developer.github.com'

# Functions

## Some icons for the functions below (prefixed so they won't annoy me in autocompletion on the shell.) Requires a Nerd Fonts patched font.
local lcicon_infoi="$FG[033]$reset_color"      # blue i
local lcicon_trash="$FG[166]$reset_color"      # orange trash
local lcicon_scissors="$FG[003]$reset_color"   # light orange scissors
local lcicon_tick="$FG[046]$reset_color"       # green tick
local lcicon_question="$FG[192]ﲉ$reset_color"   # yellow question
local lcicon_fail="$FG[009]$reset_color"       # red x
local lcicon_runarrow="$FG[077]$reset_color"   # green arrow
local lcicon_sync="$FG[077]$reset_color"       # green sync symbol
local lcicon_warning="$FG[226]$reset_color"    # yellow warning symbol
local lcicon_undo="$FG[003]\ufa4c$reset_color"  # orange undo symbol

## This is an internal function that prints a border around command exections.
### If called with no arguments, it prints a simple border.
### Otherwise, it must be called with 3 arguments: the current step, the total number of steps, and the step title message.
### e.g: lcfunc_step_border 1 3 "First step in a 3 step process!"
lcfunc_step_border() {
  local lcicon_border="$FG[013]====$reset_color"
  # if no arguments, return a border.
  if [ $# -eq 0 ]
  then
    print -P "$lcicon_border"
  else
    print -P "$lcicon_border $FG[013]$1/$2:$reset_color $3 $lcicon_border"
  fi
}

## Git functions

### Function to take git interactive rebase argument. e.g.: gir 2
gri() { git rebase -i HEAD~$1; }
gir() { git rebase -i HEAD~$1; }

### Checkout remote MRs/PRs on my local machine

#### For GitLab: e.g. gcmr upstream 12345
#### From https://docs.gitlab.com/ee/user/project/merge_requests/#checkout-merge-requests-locally
gcmr() { git fetch $1 merge-requests/$2/head:mr-$1-$2 && git checkout mr-$1-$2; }
#### This autocompletes the above function with the list of remotes
compdef -e 'words[1]=(git remote show); service=git; (( CURRENT+=2 )); _git' gcmr

#### For GitHub: e.g gcpr 12345.
#### Requires GitHUb CLI: https://github.com/cli/cli
#### Replaces old complicated function. For old function, see https://github.com/lucascosti/zshrc/blob/b371ff5404e47990d37be72c6f4c90618f019445/.zshrc#L215-L241
gcpr() { gh pr checkout $1; }

### This function prunes references to deleted remote branches, and deletes local branches that have been merged and/or deleted from the remotes.
### It is intended to be run when on a master branch, and warns when it isn't.
gclean() {
  local BRANCH=`git rev-parse --abbrev-ref HEAD`
  local response=""
  # Warning if not on a master* branch
  if [[ $BRANCH != master* ]]
  then
    print -P "$lcicon_warning$lcicon_warning $FG[009]WARNING: It looks like you are not on a master branch!$reset_color $lcicon_warning$lcicon_warning"
    vared -p "$lcicon_question Are you sure you want to continue? [y/N] " -c response
    if ! [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
    then
      print -P "$lcicon_fail Aborted! Nothing was changed."
      return 1
    fi
  fi
  
  print -P "$lcicon_infoi Simulating a clean on $BRANCH ..."
  # Step 1: Simulate a prune and save the result to a variable. Echo the variable if it is not empty.
  lcfunc_step_border 1 3 "$lcicon_scissors Simulating pruning origin $lcicon_scissors" \
  && remote_prune_list="$(git remote prune origin --dry-run)" \
  && if [ ! -z "$remote_prune_list" ]; then echo $remote_prune_list; fi
  # Step 2: check if any local branches have been merged to master. 
  lcfunc_step_border 2 3 "$lcicon_trash Simulating cleaning local branches merged to $BRANCH $lcicon_trash" \
  && git branch --merged $BRANCH | grep -v "^\**\s*master"
  # Step 3: Using the variable from step 1, check if any local branches have the same name as remote ones that would be pruned.
  # !! Be careful when looking at the result of this! !!
  # This is necessary for branches merged with the GitHub 'squash-and-merge' workflows.
  # Save the result to a variable, and echo the variable if it is not empty.
  # Inspiration for this from https://medium.com/opendoor-labs/cleaning-up-branches-with-githubs-squash-merge-43138cc7585e
  lcfunc_step_border 3 3 "$lcicon_trash Simulating cleaning local branches with same name as pruned remote ones $lcicon_trash" \
  && local_compare_to_delete="$(comm -12 <(git branch | sed 's/ *//g') <( echo $remote_prune_list | sed 's/^.*origin\///g') | xargs -L1 -J % echo %)" \
  && if [ ! -z "$local_compare_to_delete" ]; then echo $local_compare_to_delete; fi
  lcfunc_step_border
  print -P "$lcicon_infoi Simulation complete.\n"
  
  # Ask for a confirmation before proceeding with the clean
  vared -p "$lcicon_question Do you still want to do a clean? [y/N] " -c response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
  then
    # Step 1: Run a prune and save the result (i.e. the pruned branches) to a variable.
    # Step 2: delete any branches that have been merged into master
    # Step 3: Using the variable from step 1, check if any local branches have the same name as remote ones that would be pruned.
    #         If there are any branches that match, delete them.
    print -P "$lcicon_runarrow Running a clean on $BRANCH ..." \
    && lcfunc_step_border 1 3 "$lcicon_scissors Pruning origin $lcicon_scissors" \
    && remote_prune_list="$(git remote prune origin)" \
    && lcfunc_step_border 2 3 "$lcicon_trash Cleaning local branches merged to $BRANCH $lcicon_trash" \
    && git branch --merged $BRANCH | grep -v "^\**\s*master" | xargs git branch -d || true \
    && lcfunc_step_border 3 3 "$lcicon_trash Cleaning local branches with same name as pruned remote ones $lcicon_trash" \
    && comm -12 <(git branch | sed "s/ *//g") <( echo $remote_prune_list | sed "s/^.*origin\///g") | xargs -L1 -J % git branch -D % \
    && lcfunc_step_border \
    && print -P "$lcicon_tick Clean finished!"
  else
    print -P "$lcicon_fail Aborted! Nothing was changed."
    return 1
  fi
}

### Sync function for my current workflow, which only has one remote: origin.
### It rebases the current branch, with some intelligence to figure out which remote branch to rebase to:
### * If there is a branch on the remote with the same name as the current branch, use that for the rebase.
### * Otherwise, look at the tracking branch for the rebase:
###   * If there is no tracking branch, exit with an error.
###   * If the tracking branch is master, exit with an error. I probably don't want to rebase to master unless I do it explicitly myself.
###   * If the tracking branch is another branch that is not master, use that for the rebase.
gsync (){
  local REMOTE=origin
  local LOCAL_BRANCH=`git rev-parse --abbrev-ref HEAD`
  local REMOTE_BRANCH=''
  
  print -P "$lcicon_sync Syncing the current branch: $LOCAL_BRANCH"
  # Step 1: Fetch from the remote
  lcfunc_step_border 1 3 "Fetching remote $REMOTE"
  if ! git fetch $REMOTE ; then
    print -P "$lcicon_fail Fetch from remote $REMOTE failed."
    return 1
  fi
  # Step 2: Figure out which branch to rebase to
  lcfunc_step_border 2 3 "Finding which remote branch to rebase to"
  # Test if there is branch with the same name on the remote
  if git show-branch remotes/$REMOTE/$LOCAL_BRANCH > /dev/null 2>&1 ; then
    # There is a branch with the same name on the remote, use that for the rebase
    REMOTE_BRANCH=$LOCAL_BRANCH
    print -P "$lcicon_infoi Remote branch is $REMOTE/$REMOTE_BRANCH"
  else
    print -P "$lcicon_infoi No branch with the same name as $LOCAL_BRANCH on the remote. Looking at the tracking branch..."
    # Use the upstream tracking branch for the rebase, as long as it is NOT master
    if ! REMOTE_BRANCH=`git rev-parse --abbrev-ref --symbolic-full-name @{u}` > /dev/null 2>&1 ; then
      # There is no tracking branch
      print -P "$lcicon_fail Sync failed! There is no tracking branch to rebase to."
      return 1
    else
      # There is a tracking branch. Strip the 'remote/' from the start of it
      REMOTE_BRANCH=`echo $REMOTE_BRANCH | sed "s/$REMOTE\///"`
      # Test to see if the remote branch is a master branch
      if  [[ $REMOTE_BRANCH = master* ]] ; then
        # The remote upstream tracking branch is master, so don't sync it (syncing might rebase the current branch to the wrong branch).
        print -P "$lcicon_fail Sync aborted! The tracking branch is a master branch. If you want to rebase to master, you will have to do it yourself."
        return 1
      else
        # There is a proper tracking branch with a different name and is not master
        print -P "$lcicon_infoi Remote tracking branch is $REMOTE/$REMOTE_BRANCH"
      fi
    fi
  fi
  # Step 3:  Now we have all the info, do the rebase
  lcfunc_step_border 3 3 "Rebasing $LOCAL_BRANCH to $REMOTE/$REMOTE_BRANCH" \
  && git rebase $REMOTE/$REMOTE_BRANCH \
  && lcfunc_step_border \
  && print -P "$lcicon_tick Syncing finished!"
}

### Function to undo all changes (including stages) back to the last commit, with a confirmation.
gundoall () {
  local response=""
  print -P "$lcicon_warning $FG[009]WARNING:$reset_color This will delete all untracked files, and undo all changes since the previous commit."
  vared -p "$lcicon_question Are you sure? [y/N] " -c response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
  then
    print -P "$lcicon_runarrow Undoing to the previous commit..."
    lcfunc_step_border 1 2 "$lcicon_undo git reset --hard HEAD $lcicon_undo" \
    && git reset --hard HEAD \
    && lcfunc_step_border 2 2 "$lcicon_trash git clean -fd \$(git rev-parse --show-toplevel) $lcicon_trash" \
    && git clean -fd $(git rev-parse --show-toplevel) \
    && lcfunc_step_border \
    && print -P "$lcicon_tick Done!"
  else
    print -P "$lcicon_fail Aborted! Nothing was changed."
    return 1
  fi
}

# GitHub docs build stuff

## Required for GitHub docs builds bootstrap
eval "$(rbenv init -)"
eval "$(nodenv init -)"

## Build GitHub docs
alias bcurrent='bdocs'
bdocs() {
  if [ -f "script/server" ]; then
    echo "Running script/server..."
    script/server
  else
    print -P "$lcicon_fail Can't find a server script! Are you sure you are in a docs repo?"
    return 1
  fi
}
## Runs a backport then a build. 
bbackport() {
  # if there a no arguments, build all versions. For one or more specified versions as arguments, build those specified.
  if [ -z "$1" ]
    then
      versions=( 2.19 2.18 2.17 2.16 )
    else
      versions=( "$@" )
  fi
  for v in "${versions[@]}"
    do script/enterprise-backport $v
  done
  bcurrent
}


# Senstive functions which are not pushed to Github
# It contains GOPATH, some functions, aliases etc...
[ -r ~/.bash_private ] && source ~/.bash_private


if [ "$COLORTERM" == "gnome-terminal" ] || [ "$COLORTERM" == "xfce4-terminal" ]
then
TERM=xterm-256color
elif [ "$COLORTERM" == "rxvt-xpm" ]
then
TERM=rxvt-256color
fi

# Get it from the original Git repo: 
# https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
if [ -f ~/.files/git-prompt.sh ]; then
  source ~/.files/git-prompt.sh
fi

# Get it from the original Git repo: 
# https://github.com/git/git/blob/master/contrib/completion/git-completion.bash
if [ -f ~/.files/git-completion.bash ]; then
  source ~/.files/git-completion.bash
fi

###############
# Aliases (custom)
alias ..='cd ..'

# most used fast git commands
alias t="tig status"
alias tigs="tig status" #old habits don't die
alias d='git diff' 

#################
# Git
#################

alias sq='git rebase -i $(git merge-base $(git rev-parse --abbrev-ref HEAD) master)'

###############
# Exports (custom)
export GOPATH=~/go
export GOBIN=$GOPATH/bin

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:$GOBIN:$PATH"

export EDITOR="vim"

# checkout `man ls` for the meaning
export LSCOLORS=cxBxhxDxfxhxhxhxhxcxcx

export CLICOLOR=1

# enable GIT prompt options
export GIT_PS1_SHOWCOLORHINTS=true
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true

###############
# Bash settings

# -- Prompt

# This is not used anymore as we use __git_ps1 for evaluatin the PS1, just here
# in case we might need it in the future
# PS1="\[$(tput setaf 6)\]\w\[$(tput sgr0)\]\[$(tput sgr0)\] \$ "

# 1. Git branch is being showed
# 2. Title of terminal is changed for each new shell
# 3. History is appended each time
export PROMPT_COMMAND='__git_ps1 "\[$(tput setaf 6)\]\W\[$(tput sgr0)\]\[$(tput sgr0)\]" " "; echo -ne "\033]0;${PWD##*/}\007"'


# -- History

# ignoreboth ignores commands starting with a space and duplicates. Erasedups
# removes all previous dups in history
export HISTCONTROL=ignoreboth:erasedups  
export HISTFILE=~/.bash_history          # be explicit about file path
export HISTSIZE=100000                   # in memory history size
export HISTFILESIZE=100000               # on disk history size
export HISTTIMEFORMAT='%F %T '
shopt -s histappend # append to history, don't overwrite it
shopt -s cmdhist    # save multi line commands as one command

# Save multi-line commands to the history with embedded newlines
# instead of semicolons -- requries cmdhist to be on.
shopt -s lithist

# -- Completion


bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind "set completion-ignore-case on" # note: bind used instead of sticking these in .inputrc
bind "set bell-style none" # no bell
bind "set show-all-if-ambiguous On" # show list automatically, without double tab
# bind "TAB: menu-complete" # TAB syle completion

# Ignore files with these suffixes when performing completion.
export FIGNORE='.o:.pyc'

# Ignore files that match these patterns when 
# performing filename expansion.
export GLOBIGNORE='.DS_Store:*.o:*.pyc'

# -- Functions

# extracts the given file
x () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# -- Misc

# Colored man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# check windows size if windows is resized
shopt -s checkwinsize

# autocorrect directory if mispelled
shopt -s dirspell direxpand

# auto cd if only the directory name is given
shopt -s autocd

#use extra globing features. See man bash, search extglob.
shopt -s extglob

#include .files when globbing.
shopt -s dotglob

# Do not exit an interactive shell upon reading EOF.
set -o ignoreeof;

# Check the hash table for a command name before searching $PATH.
shopt -s checkhash

# Enable `**` pattern in filename expansion to match all files,
# directories and subdirectories.
shopt -s globstar

# Do not attempt completions on an empty line.
shopt -s no_empty_cmd_completion

# Case-insensitive filename matching in filename expansion.
shopt -s nocaseglob

eval "$(direnv hook bash)"

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=$HISTSIZE

# ignore case sensitivity on auto-complete for bash
bind 'set completion-ignore-case on'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

    #PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] "
    #PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    #export PS1="\[\e[00;30m\]\u\[\e[0m\]\[\e[00;31m\]:\W\[\e[0m\]\[\e[00;37m\]=>\[\e[0m\]"
    export PS1="\w\[\e[0m\]\[\e[00;37m\] =>\[\e[0m\] "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

CLICOLOR=1
TERM=xterm-256color

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# editor
#export EDITOR=em
#export SVN_EDITOR=em

function git_remote() {
  remotes=$(git remote)
  if [[ $remotes == *"upstream"* ]]; then
    echo "upstream"
  else
    echo "origin"
  fi
}

function default_branch() {
  git remote show $(git_remote) | grep 'HEAD branch' | cut -d' ' -f5
}

#alias default-branch="git branch -rl '*/HEAD' | awk -F/ '{print \$NF}'"
alias squash="git reset \$(git merge-base \${BRANCH-\$(default_branch)} \$(git rev-parse --abbrev-ref \${BRANCH-HEAD}))"

function git_sync() {
  git fetch origin --prune
  git fetch $(git_remote) --prune
  git pull $(git_remote) $(default_branch)
  git push origin $(default_branch)
}

function timeago() {
  if [ -n "$1" ]
  then
    gdate +"%Y-%m-%d" -d "$1 ago"
  else
    gdate +"%Y-%m-%d" -d "1 week ago"
  fi
}

function timestamp() {
  date +"%Y-%m-%d-%s"
}

function summary() {
  git log --since="$(timeago "$1")" --first-parent
}

function detail() {
  git lg --since="$(timeago "$1")" --first-parent
}

alias detailed="detail"

alias cdtmp="cd `mktemp -d`"

### Add ~/.bin to PATH
export PATH="${HOME}/.bin:$PATH"

### Add ~/.cargo/bin to PATH
export PATH="${HOME}/.cargo/bin:$PATH"

if command -v eza &> /dev/null
then
    alias ls="eza -l"
fi

### pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

### nodenv
export PATH="$HOME/.nodenv/bin:$PATH"

### rbenv
export PATH="$HOME/.rbenv/bin:$PATH"

### Ensure gnome-keyring-daemon is running, so we don't get prompted for SSH passwords all the time
eval `gnome-keyring-daemon --start`

#setxkbmap -option ctrl:nocaps

export GPG_TTY=$(tty)

function tmux-window-name() {
  if [ -n "$TMUX" ]; then
    ($TMUX_PLUGIN_MANAGER_PATH/tmux-window-name/scripts/rename_session_windows.py &)
  fi
}

PROMPT_COMMAND="tmux-window-name"


### START eval hooks

eval "$(direnv hook bash)"
eval "$(nodenv init - bash)"
eval "$(rbenv init - bash)"
eval "$(gh copilot alias -- bash)"

### END eval hooks




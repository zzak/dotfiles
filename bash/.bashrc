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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

CLICOLOR=1
TERM=xterm-256color

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

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
export EDITOR=em
export SVN_EDITOR=em

if [ -f /usr/local/share/chruby/chruby.sh ]; then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh

  chruby `chruby | head -1 | cut -b 4-`
fi

function new_log() {
  DATE=`date +%Y-%m-%d`
  STAMP=`date "+%a %b %e %T %Y"`

  echo "$STAMP
    " > "$DATE.md" && $EDITOR "$DATE.md"
}

function list_open_sockets() {
  find / -type s
}

function docker_clear_containers() {
  docker rm -f $(docker ps -a -q)
}

function docker_clear_images() {
  docker rmi -f $(docker images -a -q)
}

function docker_clear_volumes() {
  docker volume rm $(docker volume ls -q)
}

function genpass() {
  ruby -rsecurerandom -e 'puts SecureRandom.hex(16)'
}

if command -v brew; then
  # homebrew completion stuff
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
  if [ -f $(brew --prefix)/etc/bash_completion.d/git-completion.bash ]; then
    . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
  fi
  if [ -f `brew --prefix`/etc/bash_completion.d/git-flow-completion.bash ]; then
    . `brew --prefix`/etc/bash_completion.d/git-flow-completion.bash
  fi
fi

### Linuxbrew.sh
#export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
#export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
#export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"
#### Add Linuxbrew to your PATH
#export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

### Add JAVA_HOME
#export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"

### Add IntelliJ IDEA
export PATH="$HOME/.itj/bin:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Add ~/.bin to PATH
export PATH="${HOME}/.bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

#export GOROOT="$HOME/go"
#export GOPATH="$HOME/go"
#export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"

export PATH="$HOME/.bin/elixir/bin:$PATH"

export PATH="$PATH:$HOME/.roswell/bin"

### Firefox
export PATH="$HOME/.firefox:$PATH"

### Binaries installed by pip
export PATH="$PATH:$HOME/.local/bin"

### gometalinter
export PATH="$PATH:$HOME/.bin/gometalinter"

### pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

### Ensure gnome-keyring-daemon is running, so we don't get prompted for SSH passwords all the time
#eval `gnome-keyring-daemon --start`

#setxkbmap -option ctrl:nocaps

### nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

enter_directory() {
  if [[ $PWD == $PREV_PWD ]]; then
    return
  fi

  PREV_PWD=$PWD
  [[ -f ".nvmrc" ]] && nvm use
}

export PROMPT_COMMAND=enter_directory

### Add /usr/sbin to $PATH
export PATH="$PATH:/usr/sbin"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/zzak/src/google-cloud-sdk/path.bash.inc' ]; then . '/home/zzak/src/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/zzak/src/google-cloud-sdk/completion.bash.inc' ]; then . '/home/zzak/src/google-cloud-sdk/completion.bash.inc'; fi

export CLOUDSDK_PYTHON="/usr/local/opt/python@3.8/libexec/bin/python"

#if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk' ]; then
  source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"
  source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"
#fi

export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# editor
export EDITOR=em
export SVN_EDITOR=em

export HISTSIZE=100000

export CLICOLOR=1
export TERM=xterm-256color

#PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] "
#PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#export PS1="\[\e[00;30m\]\u\[\e[0m\]\[\e[00;31m\]:\W\[\e[0m\]\[\e[00;37m\]=>\[\e[0m\]"
export PS1="\w\[\e[0m\]\[\e[00;37m\] =>\[\e[0m\] "

if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

if [ -f /usr/local/share/chruby/chruby.sh ]; then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
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

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Add ~/.bin to PATH
export PATH="${HOME}/.bin:$PATH"

### Ensure gnome-keyring-daemon is running, so we don't get prompted for SSH passwords all the time
eval `gnome-keyring-daemon --start`

export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# editor
export EDITOR=vim
export SVN_EDITOR=vim

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

if [ -f /usr/local/opt/chruby/share/chruby/chruby.sh ]; then
  source /usr/local/opt/chruby/share/chruby/chruby.sh
  source /usr/local/opt/chruby/share/chruby/auto.sh
fi

function rtmp_open() {
  rtmpdump -r $1 --quiet | /Applications/VLC.app/Contents/MacOS/VLC fd://0 --playlist-autostart
}

function new_log() {
  DATE=`date +%Y-%m-%d`
  STAMP=`date "+%a %b %e %T %Y"`

  echo "$STAMP
    " > "$DATE.md" && $EDITOR "$DATE.md"
}

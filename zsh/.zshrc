if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

bindkey '^[^M' autosuggest-accept  # shift + tab  | autosuggest

export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"  # This loads nvm
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

#export PATH="$(brew --prefix)/opt/openjdk@11/bin:$PATH"

export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"

#for bindir in "$(brew --prefix)/opt/"*"/libexec/gnubin"; do export PATH=$bindir:$PATH; done
#for bindir in "$(brew --prefix)/opt/"*"/bin"; do export PATH=$bindir:$PATH; done
#for mandir in "$(brew --prefix)/opt/"*"/libexec/gnuman"; do export MANPATH=$mandir:$MANPATH; done
#for mandir in "$(brew --prefix)/opt/"*"/share/man/man1"; do export MANPATH=$mandir:$MANPATH; done

# Use GNU coreutils instead of the default MacOS
#export PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"

# Use GNU make instead of the default MacOS
#export PATH="$(brew --prefix)/opt/make/libexec/gnubin:$PATH"

source $(brew --prefix chruby)/share/chruby/chruby.sh
source $(brew --prefix chruby)/share/chruby/auto.sh

#export PATH="$(brew --prefix)/opt/openssl@3/bin:$PATH"
#export LIBRARY_PATH="$LIBRARY_PATH:$(brew --prefix)/opt/openssl@3/lib/"

#export PATH="$(brew --prefix)/opt/openssl@3/bin:$PATH"
#export LDFLAGS="-L$(brew --prefix)/opt/openssl@3/lib $LDFLAGS"
#export CPPFLAGS="-I$(brew --prefix)/opt/openssl@3/include $CPPFLAGS"

export PATH="$(brew --prefix openssl@1.1)/bin:$PATH"
export LDFLAGS="-L$(brew --prefix openssl@1.1)/lib $LDFLAGS"
export CPPFLAGS="-I$(brew --prefix openssl@1.1)/include $CPPFLAGS"
export PKG_CONFIG_PATH="$(brew --prefix openssl@1.1)/lib/pkgconfig:$PKG_CONFIG_PATH"

export PATH="$(brew --prefix bison)/bin:$PATH"
export PATH="$(brew --prefix libxml2)/bin:$PATH"
export PATH="$(brew --prefix libpq)/bin:$PATH"
export PATH="$(brew --prefix mysql-client)/bin:$PATH"

export LDFLAGS="-L$(brew --prefix bison)/lib $LDFLAGS"
export LDFLAGS="-L$(brew --prefix libxml2)/lib $LDFLAGS"
export LDFLAGS="-L$(brew --prefix libyaml)/lib $LDFLAGS"

export CPPFLAGS="-I$(brew --prefix libxml2)/include $CPPFLAGS"
export CPPFLAGS="-I$(brew --prefix libyaml)/include $CPPFLAGS"

export PKG_CONFIG_PATH="$(brew --prefix libxml2)/lib/pkgconfig:$PKG_CONFIG_PATH"

#export PATH="$(brew --prefix)/opt/sqlite/bin:$PATH"
export LDFLAGS="-L$(brew --prefix sqlite)/lib $LDFLAGS"
export CPPFLAGS="-I$(brew --prefix sqlite)/include $CPPFLAGS"

export LDFLAGS="-L$(brew --prefix )/lib $LDFLAGS"

export PATH="$(brew --prefix openjdk@17)/bin:$PATH"

export JAVA_HOME="$(brew --prefix openjdk@17)"

export CPPFLAGS="-I $(brew --prefix openjdk)/include $CPPFLAGS"

export WITH_OPT_DIR="$(brew --prefix openssl@1.1):$(brew --prefix readline):$(brew --prefix libyaml):$(brew --prefix gdbm)"

setopt extended_glob

alias default-branch="git branch -rl '*/HEAD' | awk -F/ '{print \$NF}'"
alias squash="git reset \$(git merge-base \${BRANCH-\$(default-branch)} \$(git rev-parse --abbrev-ref \${BRANCH-HEAD}))"

timeago() {
  if [ -n "$1" ]
  then
    date +"%Y-%m-%d" -d "$1 ago"
  else
    date +"%Y-%m-%d" -d "1 week ago"
  fi
}

summary() {
  git log --since="$(timeago "$1")" --first-parent
}

detail() {
  git lg --since="$(timeago "$1")" --first-parent
}

alias detailed="detail"

export EDITOR=code

list_open_sockets() {
  find / -type s
}

docker_clear_containers() {
  docker rm -f $(docker ps -a -q)
}

docker_clear_images() {
  docker rmi -f $(docker images -a -q)
}

docker_clear_volumes() {
  docker volume rm $(docker volume ls -q)
}

genpass() {
  ruby -rsecurerandom -e 'puts SecureRandom.hex(16)'
}

alias cdtmp="cd `mktemp -d`"

# zsh history
export HISTSIZE=1000000000
export HISTFILESIZE=$HISTSIZE
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
export HISTCONTROL=ignoredups
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "

export GPG_TTY=$(tty)

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES


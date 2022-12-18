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

export PATH="$(brew --prefix)/opt/openjdk@11/bin:$PATH"

export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"

# Use GNU coreutils instead of the default MacOS
export PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"

# Use GNU make instead of the default MacOS
export PATH="$(brew --prefix)/opt/make/libexec/gnubin:$PATH"

source $(brew --prefix)/opt/chruby/share/chruby/chruby.sh
source $(brew --prefix)/opt/chruby/share/chruby/auto.sh

#export PATH="$(brew --prefix)/opt/openssl@3/bin:$PATH"
#export LIBRARY_PATH="$LIBRARY_PATH:$(brew --prefix)/opt/openssl@3/lib/"

export PATH="$(brew --prefix)/opt/openssl@1.1/bin:$PATH"
export LDFLAGS="-L$(brew --prefix)/opt/openssl@1.1/lib"
export CPPFLAGS="-I$(brew --prefix)/opt/openssl@1.1/include"

export PATH="$(brew --prefix)/opt/bison/bin:$PATH"
export LDFLAGS="-L$(brew --prefix)/opt/bison/lib"
export PATH="$(brew --prefix)/opt/libpq/bin:$PATH"
export PATH="$(brew --prefix)/opt/mysql-client/bin:$PATH"

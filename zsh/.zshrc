# Fig pre block. Keep at the top of this file.
. "$HOME/.fig/shell/zshrc.pre.zsh"
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

bindkey '^[^M' autosuggest-accept  # shift + tab  | autosuggest

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"

export GOPATH="$HOME/go"
export GOPRIVATE=github.com/circleci/*
export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"

# Use GNU coreutils instead of the default MacOS
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

# Use GNU make instead of the default MacOS
export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"

# Fig post block. Keep at the bottom of this file.
. "$HOME/.fig/shell/zshrc.post.zsh"

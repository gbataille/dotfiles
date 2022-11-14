export PATH=$HOME/Documents/Prog/MyConfig/scripts:$GOBIN:$HOME/.cabal/bin:$PATH

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=true
export BUF_USER=gbataille
export ALGORAND_HOME=$HOME/Documents/Prog/Cryptos/AlgoNode
export ALGORAND_DATA=$ALGORAND_HOME/testnetdata
eval "$(pyenv init --path)"

[[ -f "$HOME/.cargo/env" ]] && . $HOME/.cargo/env

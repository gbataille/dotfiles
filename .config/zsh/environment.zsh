export ALGORAND_DATA=$ALGORAND_HOME/testnetdata
export ALGORAND_HOME=$HOME/Documents/Prog/Cryptos/AlgoNode
export AWS_ASSUME_ROLE_TTL=4h
export AWS_CHAINED_SESSION_TOKEN_TTL=1h
export AWS_FEDERATION_TOKEN_TTL=4h
export AWS_PAGER=
export AWS_SESSION_TOKEN_TTL=4h
export BUF_USER=gbataille
export CC=clang
export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"
export CPPFLAGS="-I$(xcrun --show-sdk-path)/usr/include"
export EDITOR=nvim
export GITHUD_DEBUG=TRUE
export GOBIN=$GOPATH/bin
export GOPATH=$HOME/go
export GOPRIVATE=
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=true
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LDFLAGS="-I$(xcrun --show-sdk-path)/usr/include"
if ! [[ "$PATH" =~ 'MyConfig' ]] then
  export PATH=/opt/homebrew/bin:$HOME/Documents/Prog/MyConfig/scripts:$XDG_DATA_HOME/nvim/mason/bin:$PATH
fi
export PYENV_ROOT="$HOME/.pyenv"
export PYTHONBREAKPOINT=ipdb.set_trace
export PYTHONPATH=$HOME/Documents/Prog/Perso/pytoolkit:$PYTHONPATH
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export SHELL_USER=gbataille
export TZ=Europe/Paris
export WORKON_HOME=$HOME/.virtualenvs
export ZSH_HIGHLIGHT_MAXLENGTH=60     # For perf on text paste
# RUST
export RUST_BACKTRACE=1

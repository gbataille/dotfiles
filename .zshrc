# https://stackoverflow.com/questions/20357441/zsh-on-10-9-widgets-can-only-be-called-when-zle-is-active
TRAPWINCH() {
  zle && { zle reset-prompt; zle -R }
}

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gba"
# ZSH_THEME="agnoster"
# DEFAULT_USER="gbataille"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(autojump nix-shell)
source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

set -o vi

bindkey -v 

# vi style incremental search
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward 
bindkey '^R' fzf-history-widget

export EDITOR=nvim
export CC=clang
export TZ=Europe/Paris
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export WORKON_HOME=$HOME/.virtualenvs
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export GOPRIVATE=github.com/t-dx/*,github.com/taurusgroup/*
export PYTHONPATH=$HOME/Documents/Prog/Perso/pytoolkit:$PYTHONPATH
export PYTHONBREAKPOINT=ipdb.set_trace
export PYENV_ROOT="$HOME/.pyenv"
export AWS_ASSUME_ROLE_TTL=4h
export AWS_CHAINED_SESSION_TOKEN_TTL=1h
export AWS_FEDERATION_TOKEN_TTL=4h
export AWS_SESSION_TOKEN_TTL=4h
export AWS_PAGER=
export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"
export CPPFLAGS="-I$(xcrun --show-sdk-path)/usr/include"
export LDFLAGS="-I$(xcrun --show-sdk-path)/usr/include"
export ZSH_HIGHLIGHT_MAXLENGTH=60     # For perf on text paste
export GITHUD_DEBUG=TRUE
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export SHELL_USER=gbataille
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=true
export BUF_USER=gbataille
export ALGORAND_HOME=$HOME/Documents/Prog/Cryptos/AlgoNode
export ALGORAND_DATA=$ALGORAND_HOME/testnetdata

export PATH=$PYENV_ROOT/bin:$HOME/Documents/Prog/MyConfig/scripts:$GOBIN:$HOME/.cabal/bin:$PATH

# RUST
export RUST_BACKTRACE=1

alias ..='cd ..'
alias branchclean='git branch --merged | grep -v "\*" | grep -v master | grep -v staging | xargs -n 1 git branch -d'
alias c='clear'
alias cdg='cd ~/Documents/Prog/GregsSandbox/'
alias cdm='cd ~/Documents/Prog/MyConfig'
alias cdp='cd ~/Documents/Prog/'
alias ghpr='gh pr checkout'
alias gitk='gitk --all'
alias ls='ls -Gh'
alias logj='jq -R -r ". as \$line | try (fromjson | \"[\" + .ts + \"][\" + (.level | ascii_upcase) + \"] \" + (if has(\"error\") then (.error + \" - \") else \"\" end)  + .msg + \" \" + (.block_number? | tostring) + \" (\" + .caller + \")\" + \"\\n\\t\" + (\$line|fromjson|del(.msg)|del(.ts)|del(.caller)|del(.level)|del(.block_number)|tostring)) catch \$line"'
alias mergeclean='rm $(find . -name "*BACKUP*");rm $(find . -name "*REMOTE*");rm $(find . -name "*LOCAL*");rm $(find . -name "*BASE*")'
alias mergedremotebranch='git branch -r --merged | grep origin | grep -v ">" | grep -v master | grep -v staging | grep -v "rc-" | xargs -L1'
alias npmr='npm run'
alias npmrs='npm run -s'
alias origclean='rm $(find . -name "*.orig")'
alias pm='python manage.py'
alias pmr='python manage.py runserver 0.0.0.0:8000'
alias pms='python manage.py shell_plus'
alias pmt='python manage.py test'
alias pmtk='LOG_LEVEL=WARNING python manage.py test -v 2 --keepdb'
alias pyclean='rm $(find . -name "*.pyc"); rm -r $(find . -name "__pycache__")'
alias rgall='rg --hidden --no-ignore'
alias sshadd='ssh-add ~/.ssh/id_rsa'
alias tf='terraform'
alias ys='yarn start'
alias yt='yarn test -- --verbose'

cat()
{
  bat $@
}
unalias ll
ll()
{
  exa -la --git -F $@
}
alias l='ll'
tree()
{
  exa -la --git -F -T -I ".mypy_cache|.DS_Store|__pycache__|.git|node_modules" $@
}

if [ -f /usr/local/bin/nvim ]; then
  alias vi='/usr/local/bin/nvim'
elif [ -f /usr/local/bin/vim ]; then
  alias vi='/usr/local/bin/vim'
fi
if [ -f /usr/local/bin/find ]; then
  alias find='/usr/local/bin/find'
fi

aws_get_account_id()
{
  ave $1 -- aws sts get-caller-identity --output text --query 'Account'
}
aws_get_canonical_account_id()
{
  ave $1 -- aws s3api list-buckets --query Owner.ID
}

# Init SSH keys
# init_ssh_keys.sh
# Setup local DNS
# setup_host_file.sh

avmfa() {
  ykman oath accounts code | grep aws-sdc | awk '{print $2}' | pbcopy
}
ave()
{
  aws-vault exec --prompt=ykman $@
}
avl()
{
  aws-vault login -d 1h --prompt=ykman $@
}
avpmr()
{
  aws-vault exec --prompt=ykman $@ -- python manage.py runserver 0.0.0.0:8000
}
avpms()
{
  aws-vault exec --prompt=ykman $@ -- python manage.py shell_plus
}
vpn_down()
{
  sudo wg-quick down $1
}
vpn_up()
{
  sudo wg-quick up $1
}

# TOOLS
[[ -f `brew --prefix`/etc/bash_completion ]] && . `brew --prefix`/etc/bash_completion
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

generate_random_alpha()
{
  if [ -z "$1" ]; then; echo "Please pass a length as parameter"; return; fi
  LC_ALL=C tr -dc 'A-Za-z0-9' </dev/urandom | head -c $1 | pbcopy
}

generate_random()
{
  if [ -z "$1" ]; then; echo "Please pass a length as parameter"; return; fi
  LC_ALL=C tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' </dev/urandom | head -c $1 | pbcopy
}

## Python
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

## Rust
[[ -f "$HOME/.cargo/env" ]] && . $HOME/.cargo/env

## Node
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

## Ruby
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# DIRENV
eval "$(direnv hook zsh)"

# GRC
[[ -s "/usr/local/etc/grc.zsh" ]] && source /usr/local/etc/grc.zsh
export GPG_TTY=$(tty)

# Add .zsh to your fpath when the zsh shell starts
fpath+=~/.config/completions/zsh

# Zellij
function zr () { zellij run --name "$*" -- zsh -ic "$*";}
function zrf () { zellij run --name "$*" --floating -- zsh -ic "$*";}
function ze () { zellij edit "$*";}
function zef () { zellij edit --floating "$*";}

# TG
[[ -s "$HOME/.tgrc" ]] && source $HOME/.tgrc

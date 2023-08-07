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

# Start oh-my-zsh
source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

set -o vi

bindkey -v 

# vi style incremental search
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward 
bindkey '^R' fzf-history-widget

# Add .zsh to your fpath when the zsh shell starts
fpath+=~/.config/completions/zsh

# Load configs
[ -f ~/.config/zsh/environment.zsh ] && source ~/.config/zsh/environment.zsh

[ -f ~/.config/zsh/.fzf.zsh ] && source ~/.config/zsh/.fzf.zsh
[ -f ~/.config/zsh/alias.zsh ] && source ~/.config/zsh/alias.zsh
[ -f ~/.config/zsh/aws.zsh ] && source ~/.config/zsh/aws.zsh
[ -f ~/.config/zsh/brew-completion.zsh ] && source ~/.config/zsh/brew-completion.zsh
[ -f ~/.config/zsh/direnv.zsh ] && source ~/.config/zsh/direnv.zsh
[ -f ~/.config/zsh/go.zsh ] && source ~/.config/zsh/go.zsh
[ -f ~/.config/zsh/grc.zsh ] && source ~/.config/zsh/grc.zsh
[ -f ~/.config/zsh/node.zsh ] && source ~/.config/zsh/node.zsh
[ -f ~/.config/zsh/python.zsh ] && source ~/.config/zsh/python.zsh
[ -f ~/.config/zsh/random.zsh ] && source ~/.config/zsh/random.zsh
[ -f ~/.config/zsh/ruby.zsh ] && source ~/.config/zsh/ruby.zsh
[ -f ~/.config/zsh/rust.zsh ] && source ~/.config/zsh/rust.zsh
[ -f ~/.config/zsh/zellij.zsh ] && source ~/.config/zsh/zellij.zsh

[ -f ~/.config/zsh/taurus.zsh ] && source ~/.config/zsh/taurus.zsh


# Load Angular CLI autocompletion.
source <(ng completion script)

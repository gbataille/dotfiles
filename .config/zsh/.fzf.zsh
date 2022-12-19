# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/gbataille/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/gbataille/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/gbataille/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/gbataille/.fzf/shell/key-bindings.zsh"

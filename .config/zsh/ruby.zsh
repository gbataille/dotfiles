if ! [[ "$PATH" =~ '\.rbenv/bin' ]] then
  eval "$(rbenv init -)"
  export PATH="$HOME/.rbenv/bin:$PATH"
fi

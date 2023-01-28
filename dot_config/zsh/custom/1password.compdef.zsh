# Do nothing if op is not installed
(( ${+commands[op]} )) || return

# Ask for op's completion and load it
eval "$(op completion zsh)"
compdef _op op

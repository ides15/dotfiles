# Unbind down arrow
bindkey -r "^[[B"
bindkey -r "^[OB"
# Use <C-n> to select the next command
bindkey "^N" down-line-or-beginning-search

# Unbind up arrow
bindkey -r "^[[A"
bindkey -r "^[OA"
# Use <C-p> to select the previous command
bindkey "^P" up-line-or-beginning-search


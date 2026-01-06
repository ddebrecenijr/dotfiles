plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

### Global Aliases ###
alias -g L="| less"
alias -g X="| xclip -selection c"
alias -g T="| tee -a"
alias -g G="| grep -ni"

### Aliases ###
alias update="source ~/.zshrc"
alias vim="nvim"

### Functions ###

### EOF ###
autoload -Uz compinit && compinit

eval "$(starship init zsh)"

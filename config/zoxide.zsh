if (( $+commands[zoxide] )); then
    eval "$(zoxide init --cmd cd zsh)"
    return
fi


# If starship is installed, use starship:
if (( $+commands[starship] )); then
    eval "$(starship init zsh)"
    return
fi

#If not, use pure

SYMBOLS=(
    "❯"
    "→"
    "»"
    "৸"
)

ERROR_SYMBOLS=(
    "⎋"
    "⊘"
    "⊗"
    "×"
)

export PURE_PROMPT_SYMBOL="${SYMBOLS[$RANDOM % ${#SYMBOLS[@]}]}"
export PURE_PROMPT_SYMBOL_ERROR="${ERROR_SYMBOLS[$RANDOM % ${#ERROR_SYMBOLS[@]}]}"

autoload -Uz promptinit;
promptinit
prompt pure

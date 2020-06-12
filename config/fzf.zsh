# ┌──────┐
# │ FZF  │
# └──────┘
FZF_CMD='fd --hidden --follow --no-ignore-vcs --exclude ".git/*" --exclude ".git" --exclude "node_modules/*" --exclude "tags"'
export FZF_DEFAULT_OPTS='--min-height 30 --bind esc:cancel --height 50% --reverse --tabstop 2 --multi --preview-window wrap --cycle'
export FZF_DEFAULT_COMMAND="$FZF_CMD --type f"
export FZF_CTRL_T_COMMAND="$FZF_CMD"
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --header 'Press CTRL-Y to copy command into clipboard' --border"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_ALT_C_CMD="$FZF_CMD --type d ."
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh


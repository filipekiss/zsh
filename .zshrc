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

# ┌──────────┐
# │ Homebrew │
# └──────────┘
export HOMEBREW_INSTALL_BADGE="🔮"
export HOMEBREW_NO_ANALYTICS=1

# ┌────────┐
# │ Direnv │
# └────────┘
if [ $(command -v direnv) ]; then
    export NODE_VERSIONS="${HOME}/.node-versions"
    export NODE_VERSION_PREFIX=""
    eval "$(direnv hook zsh)"
fi

# ┌────┐
# │ FZ │
# └────┘
export FZ_HISTORY_CD_CMD="_zlua"

# ┌────────────────────┐
# │ Load local configs │
# └────────────────────┘

if [[ -f ${HOME}/.zshrc.local ]]; then
    source $HOME/.zshrc.local
else
    [[ -z "${HOMEBREW_GITHUB_API_TOKEN}" ]] && echo "⚠ HOMEBREW_GITHUB_API_TOKEN not set." && _has_unset_config=yes
    [[ -z "${GITHUB_TOKEN}" ]] && echo "⚠ GITHUB_TOKEN not set." && _has_unset_config=yes
    [[ -z "${GITHUB_USER}" ]] && echo "⚠ GITHUB_USER not set." && _has_unset_config=yes
    [[ ${_has_unset_config:-no} == "yes" ]] && echo "Set the missing configs in ~/.zshrc"
fi
# ┌─────────┐
# │ Profile │
# └─────────┘
# Uncomment the line below and start a new shell. Don't forget to uncomment the
# `zprof` portion on .zshenv
# zprof

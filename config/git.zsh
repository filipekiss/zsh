[[ -n $NVIM_LISTEN_ADDRESS ]] && export GIT_EDITOR="nvr --remote-wait-silent"
[[ $TERM_PROGRAM == "vscode" ]] && export GIT_EDITOR="code --wait"
export GIT_MERGE_AUTOEDIT=no


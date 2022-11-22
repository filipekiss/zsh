[[ -n $NVIM_LISTEN_ADDRESS ]] && export GIT_EDITOR="nvr --remote-wait-silent"
[[ $TERM_PROGRAM == "vscode" ]] && export GIT_EDITOR="code --wait"
[[ -n $NVIM_UNCEPTION_PIPE_PATH_HOST ]] && export GIT_EDITOR="nvim --cmd 'let g:unception_block_while_host_edits=1'"
export GIT_MERGE_AUTOEDIT=no


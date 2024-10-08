# ┌─────────┐
# │ Editors │
# └─────────┘

# Set nvim as editor or use vim if nvim is not available
if [[ $TERM_PROGRAM == "vscode" ]]; then
  export EDITOR="code"
elif [[ -n ${NVIM_LISTEN_ADDRESS} ]]; then
    (( $+commands[nvr] )) && export EDITOR="nvr -l" || export EDITOR=nvim
else
    (( $+commands[nvim] )) && export EDITOR=nvim || export EDITOR=vim
fi

export NOTES_EDITOR=$EDITOR
[[ -z $GIT_EDITOR ]] && export GIT_EDITOR=$EDITOR
export VISUAL=$GIT_EDITOR

# Set less or more as the default pager.
if (( ${+commands[less]} )); then
    export PAGER=less
else
    export PAGER=more
fi

# Set MANPAGER based on $EDITOR
case $EDITOR in
    nvim) export MANPAGER="nvim -c 'set ft=man | set showtabline=1 | set laststatus=0' +Man!" ;;
     vim) export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man' -\"" ;;
       *) export MANPAGER=$PAGER ;;
esac

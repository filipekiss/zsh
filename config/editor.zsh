# ┌─────────┐
# │ Editors │
# └─────────┘

# Set nvim as editor or use vim if nvim is not available
if [[ -n ${NVIM_LISTEN_ADDRESS} ]]; then
    (( $+commands[nvr] )) && export EDITOR="nvr -l" || export EDITOR=nvim
else
    (( $+commands[nvim] )) && export EDITOR=nvim || export EDITOR=vim
fi

export VISUAL=$EDITOR
export NOTES_EDITOR=$EDITOR

# Set less or more as the default pager.
if (( ${+commands[less]} )); then
    export PAGER=less
else
    export PAGER=more
fi

# Set MANPAGER based on $EDITOR
case $EDITOR in
    nvim) export MANPAGER="nvim +'set ft=man' -" ;;
     vim) export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man' -\"" ;;
       *) export MANPAGER=$PAGER ;;
esac

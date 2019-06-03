# Editor Wrapper to support neovim-remote

# If not inside TMUX, just alias e to EDITOR, no need to all this roundabouts
[[ -z $TMUX ]] && alias e=$EDITOR && return 0

# Check if neovim is our editor of choice
[[ $EDITOR == *"nvim" ]] && __is_editor_nvim="yes"

# If we don't have nvim installed just alias e to $EDITOR and be done with it
[[ -z $__is_editor_nvim ]] && alias e=$EDITOR && return 0

# Check for NVR
(( $+commands[nvr] )) && __is_nvr_installed="yes"

# If we don't have NVR installed, just alias e to $EDITOR and be done with it
[[ -z $__is_nvr_installed ]] && alias e=$EDITOR && return 0

unalias e 2>/dev/null
unalias :e 2>/dev/null

# Let's export the $EDITOR and NVIM_LISTEN_ADDRESS to use nvr and the current
# session socket. Mainly so git also benefits from nvr
local __current_tmux_session=$(tmux display-message -p '#S')
local __current_session_window=$(tmux display-message -p '#I')
# Replace slashes on session name to prevent socket creation errors
__current_tmux_session=${__current_tmux_session//\//-}
export NVIM_LISTEN_ADDRESS="/tmp/nvimsocket-${__current_tmux_session}-${__current_session_window}"
export EDITOR="nvr"
export VISUAL=$EDITOR
export GIT_EDITOR="$EDITOR --remote-wait-silent -s --servername=$NVIM_LISTEN_ADDRESS"

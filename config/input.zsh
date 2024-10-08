##################################
# Editor and input char assignment
##################################

# Return if requirements are not found.
if [[ ${TERM} == 'dumb' ]]; then
  return 1
fi

# Use human-friendly identifiers.
zmodload zsh/terminfo
typeset -gA key_info
key_info=(
  'Control'      '\C-'
  'ControlLeft'  '\e[1;5D \e[5D \e\e[D \eOd \eOD'
  'ControlRight' '\e[1;5C \e[5C \e\e[C \eOc \eOC'
  'Escape'       '\e'
  'Meta'         '\M-'
  'Backspace'    "^?"
  'Delete'       "^[[3~"
  'F1'           "${terminfo[kf1]}"
  'F2'           "${terminfo[kf2]}"
  'F3'           "${terminfo[kf3]}"
  'F4'           "${terminfo[kf4]}"
  'F5'           "${terminfo[kf5]}"
  'F6'           "${terminfo[kf6]}"
  'F7'           "${terminfo[kf7]}"
  'F8'           "${terminfo[kf8]}"
  'F9'           "${terminfo[kf9]}"
  'F10'          "${terminfo[kf10]}"
  'F11'          "${terminfo[kf11]}"
  'F12'          "${terminfo[kf12]}"
  'Insert'       "${terminfo[kich1]}"
  'Home'         "${terminfo[khome]}"
  'PageUp'       "${terminfo[kpp]}"
  'End'          "${terminfo[kend]}"
  'PageDown'     "${terminfo[knp]}"
  'Up'           "${terminfo[kcuu1]}"
  'Left'         "${terminfo[kcub1]}"
  'Down'         "${terminfo[kcud1]}"
  'Right'        "${terminfo[kcuf1]}"
  'BackTab'      "${terminfo[kcbt]}"
)

# Bind the keys

# Vim mode
bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

# Remove ^G (list-expand) so we can use our fzf-widgets
bindkey -r '^G'

# History Substring Configuration - https://github.com/zsh-users/zsh-history-substring-search#usage
bindkey "${key_info[Up]}" history-substring-search-up
bindkey "${key_info[Down]}" history-substring-search-down
# Also works in vicmd
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Clear
bindkey "${key_info[Control]}L" clear-screen

# Bind Shift + Tab to go to the previous menu item.
if [[ -n "${key_info[BackTab]}" ]]; then
  bindkey "${key_info[BackTab]}" reverse-menu-complete
fi

# Use ! in normal mode to edit the current line
# Use a custom widget so my editor is always $GIT_EDITOR, that waits for the
# editor
function nvr-edit-command-line() {
    autoload -Uz edit-command-line
    zle -N edit-command-line
    VISUAL=$GIT_EDITOR edit-command-line
}
zle -N nvr-edit-command-line
bindkey -M vicmd '!'  nvr-edit-command-line
bindkey "^X^E" nvr-edit-command-line

# Automatically expand .... to ../..
double-dot-expand() {
  if [[ ${LBUFFER} == *... ]]; then
    LBUFFER="${LBUFFER%.}/.."
  else
    LBUFFER+='.'
  fi
}
zle -N double-dot-expand
bindkey "." double-dot-expand

# Put into application mode and validate ${terminfo}
zle-line-init() {
  if (( ${+terminfo[smkx]} )); then
    echoti smkx
  fi
}
zle-line-finish() {
  if (( ${+terminfo[rmkx]} )); then
    echoti rmkx
  fi
}
zle -N zle-line-init
zle -N zle-line-finish

for widget (${ZDOTDIR:-$HOME}/widgets/*.zsh) source $widget

# Ensure no delay when changing modes
export KEYTIMEOUT=1

#######################################################################################################
# Expand aliases
# http://www.math.cmu.edu/~gautam/sj/blog/20140625-zsh-expand-alias.html
# https://github.com/ninrod/dotfiles/blob/c78cc190c523f765595c158b2953cdad8d4d07e9/zsh/expand-alias.zsh
#######################################################################################################

function expand-ealias() {
  if [[ $LBUFFER =~ "(^|[;|&])\s*(${(j:|:)ealiases})\$" ]]; then
	zle _expand_alias
	zle expand-word
  fi
  zle magic-space
}

zle -N expand-ealias

bindkey -M viins ' '        expand-ealias
bindkey -M viins '^ '       magic-space     # control-space to bypass completion
bindkey -M isearch " "      magic-space     # normal space during searches

# FZF Folder Widget
bindkey '^q' fzf-cd-widget

# Undo using Ctrl _
bindkey '^_' undo

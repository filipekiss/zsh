# ┌─────────────────────────┐
# │ Completion enhancements │
# └─────────────────────────┘

# if it's a dumb terminal, return.
if [[ ${TERM} == 'dumb' ]]; then
  return 1
fi

# load and initialize the completion system
autoload -Uz compinit && compinit -d "${ZDOTDIR:-${HOME}}/${zcompdump_file:-.zcompdump}"

# ┌─────────────┐
# │ zsh options │
# └─────────────┘

# If a completion is performed with the cursor within a word, and a full completion is inserted,
# the cursor is moved to the end of the word
setopt ALWAYS_TO_END

# Automatically use menu completion after the second consecutive request for completion
setopt AUTO_MENU

# Automatically list choices on an ambiguous completion.
setopt AUTO_LIST

# Perform a path search even on command names with slashes in them.
setopt PATH_DIRS

# Make globbing (filename generation) sensitive to case.
unsetopt CASE_GLOB

# On an ambiguous completion, instead of listing possibilities or beeping, insert the first match immediately.
# Then when completion is requested again, remove the first match and insert the second match, etc.
unsetopt MENU_COMPLETE

# Pass bad arguments directly to commands, so ZSH won't complain
# https://github.com/robbyrussell/oh-my-zsh/issues/449#issuecomment-6973326
unsetopt NOMATCH

# ┌───────────────────────────┐
# │ completion module options │
# └───────────────────────────┘

# group matches and describe.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# directories
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'expand'
zstyle ':completion:*' squeeze-slashes true

# enable caching
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${ZDOTDIR:-${HOME}}/.zcompcache"

# ignore useless commands and functions
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec)|prompt_*)'

# completion sorting
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# history
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# ignore multiple entries.
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'

# ignore specific files when autocompleting for specific commands
zstyle ':completion:*:*:(nvim|vim|e|l|less):*' file-patterns '^(package-lock.json|yarn.lock):source-files' '*:all-files'        #...package-lock.json and yarn.lock

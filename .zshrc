# ┌───────────────────┐
# │ PATH Glob Options │
# ├───────────────────┴────────────────────────────────────────────────────┐
# │ (N-/).... do not register if the directory does not exists             │
# │ N........ NULL_GLOB option (ignore path if it does not match the glob) │
# │ n........ sort the output                                              │
# │ [-1]..... select the last item in the array                            │
# │ -........ follow the symbol links                                      │
# │ /........ ignore files                                                 │
# └────────────────────────────────────────────────────────────────────────┘

# ┌───────────────────────────────┐
# │ Ensure no duplicates in paths │
# └───────────────────────────────┘
typeset -gU cdpath fpath manpath path

fpath=(
    ${ZDOTDIR:-$HOME}/functions/functions.zwc(N-)
    ${ZDOTDIR:-$HOME}/completion/completion.zwc(N-)
    ${ZDOTDIR:-$HOME}/functions(N-/)
    ${ZDOTDIR:-$HOME}/completion(N-/)
    ${ZDOTDIR:-$HOME}/prompt/prompt.zwc(N-)
    ${ZDOTDIR:-$HOME}/prompt/functions(N-/)
    /opt/homebrew/share/zsh/site-functions(N-/)
    ${fpath}
)

() {
    setopt EXTENDED_GLOB
    autoload -Uz ${ZDOTDIR:-$HOME}/functions/^*.zwc*
    autoload -Uz ${ZDOTDIR:-$HOME}/completion/^*.zwc*
}


# ┌───────────────────────────────────────────┐
# │ Get the original manpath, then modify it. │
# └───────────────────────────────────────────┘
(( $+commands[manpath] )) && MANPATH="`manpath`"
manpath=(
    ${HOMEBREW_PREFIX:-/usr/local}/opt/*/libexec/gnuman(N-/)
    "$manpath[@]"
)

# ┌─────────────────────────────────────────────────────────────┐
# │ Set the list of directories that Zsh searches for programs. │
# └─────────────────────────────────────────────────────────────┘
path=(
    ./bin(N-/)
    ./node_modules/.bin
    ${ZDOTDIR}/bin(N-/)
    ${HOME}/.bin/local(N-/)
    ${HOME}/.bin(N-/)
    ${HOME}/.cargo/bin(N-/)
    ${HOME}/.volta/bin(N-/) # https://volta.sh
    ${XDG_CONFIG_HOME}/yarn/global/node_modules/.bin(N-/)
    ${GOPATH}/bin(N-/)
    ${HOMEBREW_PREFIX:-/opt/homebrew}/opt/coreutils/libexec/gnubin(N-/)
    ${HOMEBREW_PREFIX:-/opt/homebrew}/opt/python/libexec/bin(N-/)
    ${HOMEBREW_PREFIX:-/opt/homebrew}/opt/findutils/libexec/gnubin(N-/)
    ${HOMEBREW_PREFIX:-/opt/homebrew}/opt/curl/bin(N-/)
    ${HOMEBREW_PREFIX:-/opt/homebrew}/opt/openssh/bin(N-/)
    $HOME/Library/Python/3.*/bin(Nn[-1]-/)
    ${HOMEBREW_PREFIX:-/opt/homebrew}/{bin,sbin}(N-/)
    $path
)

# ┌─────────┐
# │ Plugins │
# └─────────┘
#
# This is a key value array: key is the folder name inside plugins and value is
# the path for the file to be sourced
() {
    setopt EXTENDED_GLOB
    typeset -A zplugins
    zplugins=(
        f-sy-h            fast-syntax-highlighting.plugin.zsh
        history-substring zsh-history-substring-search.zsh
        zsh-completions   zsh-completions.plugin.zsh
        z.lua             z.lua.plugin.zsh
        fz                fz.plugin.zsh
    )
    for plugin file in ${(kv)zplugins}; do
        plugin_path=${ZDOTDIR:-$HOME}/plugins/${plugin}/${file}
        for file in ${~plugin_path}(N); do
            source ${~file}
        done;
    done
}

# ┌────────────────┐
# │ Configurations │
# └────────────────┘
#
# The array is used to load the settings in the desired order
zconfig=(
    cli-format
    completion
    compdefs
    directory
    environment
    expand-alias
    git
    git-alias
    gpg
    hash
    history
    input
    prompt
    editor
    nvr
    aliases
    fzf
    homebrew
    direnv
)

for config (${ZDOTDIR:-$HOME}/config/${^zconfig}.zsh) source $config && unset config

# ┌────┐
# │ FZ │
# └────┘
export FZ_HISTORY_CD_CMD="_zlua"

#  ┌────────────────────────────────────────────────────────┐
#  │ Make sure git completions are the good ones            │
#  │ For reference: https://github.com/github/hub/pull/1962 │
#  └────────────────────────────────────────────────────────┘
(
if [ -e /usr/local/share/zsh/site-functions/_git ]; then
    command mv -f /usr/local/share/zsh/site-functions/{,disabled.}_git 2>/dev/null
    command mv -f /usr/local/share/zsh/site-functions/{,disabled.}git-completion.bash 2>/dev/null
fi
) &!

# ┌────────────────────┐
# │ Load local configs │
# └────────────────────┘

if [[ -f ${HOME}/.zshrc.local ]]; then
    source $HOME/.zshrc.local
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

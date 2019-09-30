
# ┌───────────┐
# │ .zprofile │
# ├───────────┴───────────────────────────────────────────────────────────┐
# │ This file should be used to set up the paths for the shell. This file │
# │ should not produce any output.                                        │
# └───────────────────────────────────────────────────────────────────────┘
#
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
    /usr/local/share/zsh/site-functions(N-/)
    ${fpath}
)

() {
    setopt EXTENDED_GLOB
    autoload -Uz ${ZDOTDIR:-$HOME}/functions/^*.zwc*
}


# ┌───────────────────────────────────────────┐
# │ Get the original manpath, then modify it. │
# └───────────────────────────────────────────┘
(( $+commands[manpath] )) && MANPATH="`manpath`"
manpath=(
    ${HOMEBREW_ROOT:-/usr/local}/opt/*/libexec/gnuman(N-/)
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
    ${HOMEBREW_ROOT:-/usr/local}/opt/python/libexec/bin(N-/)
    ${HOMEBREW_ROOT:-/usr/local/}{bin,sbin}(N-/)
    ${HOMEBREW_ROOT:-/usr/local}/opt/coreutils/libexec/gnubin(N-/)
    ${HOMEBREW_ROOT:-/usr/local}/opt/findutils/libexec/gnubin(N-/)
    ${XDG_CONFIG_HOME}/yarn/global/node_modules/.bin(N-/)
    ${GOPATH}/bin(N-/)
    $HOME/Library/Python/3.*/bin(Nn[-1]-/)
    $path
)

# ┌─────┐
# │ NVM │
# └─────┘
#
# This is here because it needs to be set before NVM is loaded
NVM_LAZY_LOAD=true
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
        nvm               zsh-nvm.plugin.zsh
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
    aliases
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
    nvr
    prompt
)

for config (${ZDOTDIR:-$HOME}/config/${^zconfig}.zsh) source $config && unset config

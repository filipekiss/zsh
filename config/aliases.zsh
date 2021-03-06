# ┌─────────┐
# │ Aliases │
# └─────────┘
alias :e="${aliases[:e]:-e}"
alias cp="${aliases[cp]:-cp} -irv"
alias ll="${aliases[ll]:-ll} -v"
alias ln="${aliases[ln]:-ln} -iv"
alias ls="${aliases[ls]:-ls} -v"
alias la="${aliases[la]:-ls} -la"
alias mkdir="${aliases[mkdir]:-mkdir} -p"
alias mv="${aliases[mv]:-mv} -iv"
alias ping="${aliases[ping]:-ping} -c 4"
alias rm="${aliases[rm]:-rm} -i"
alias rsync="${aliases[rsync]:-rsync} -rpltDv --filter=':- .gitignore'"
alias type="${aliases[type]:-type} -a"
alias dots="cd ${DOTFILES:-${HOME}/.dotfiles}"
alias getPath='echo $PATH | tr -s ":" "\n"'
alias groot='cd $(git rev-parse --show-toplevel || echo $HOME)'
alias shutdown='sudo shutdown'

# ┌──────────────────────┐
# │ Ranger file explorer │
# └──────────────────────┘
if (( $+commands[ranger] )); then
    unalias r 2>/dev/null
    alias r=ranger
fi

# ┌───────────┐
# │ Hub Alias │
# └───────────┘
if (( $+commands[hub] )); then
    alias git=hub
fi

# ┌───────────────┐
# │ File Download │
# └───────────────┘
if (( $+commands[aria2c] )); then
  alias get='aria2c --continue --remote-time --file-allocation=none'
elif (( $+commands[curl] )); then
  alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif (( $+commands[wget] )); then
  alias get='wget --continue --progress=bar --timestamping'
fi

if (( $+commands[htop] )); then
  alias top=htop
fi

# ┌───────────────────────────┐
# │ Python Simple HTTP Server │
# └───────────────────────────┘
if (( $+commands[python3] )); then
    alias server="sudo python3 -m http.server 80"
fi

# ┌────────────────┐
# │ Resource Usage │
# └────────────────┘
alias df='df -kh'
alias du='du -kh'

# ┌─────────────────┐
# │ Global Aliases  │
# └─────────────────┘
alias -g C='| pbcopy'

if (( $+commands[rg] )); then
    alias -g G='| rg'
else
    alias -g G='|grep -i '
fi
if (( $+commands[xargs] )); then
    alias -g X='| xargs'
fi

if (( $+commands[lsd] )); then
  alias ll="lsd --tree"
elif (( $+commands[tree] )); then
  alias ll="type tree >/dev/null && tree -da -L 1 || l -d .*/ */ "
else
  alias ll="echo 'You have to install exa or tree'"
fi

# ┌──────────────┐
# │ Useful stuff │
# └──────────────┘
alias "?"="pwd"
alias flushcache="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"

# ┌─────────────────────────────────────────────────┐
# │ SSH when in TMUX needs to explicitly pass $TERM │
# └─────────────────────────────────────────────────┘
[[ $TERM == *"tmux"* ]] && alias ssh="TERM=xterm-256color ssh"

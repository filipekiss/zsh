compdef '_files' diff
compdef '_files' e
compdef '_cd' mcd
compdef '_rm' rm
compdef '_cd' ss
compdef '_files' touche
compdef '_files' transfer
(( $+functions[_brew_cask] )) && compdef '_brew_cask' cask
(( $+functions[_git] )) && compdef g=git
(( $+functions[_npm] )) && compdef n=npm
(( $+functions[_open] )) && compdef o=open
(( $+functions[_yarn] )) && compdef y=yarn
(( $+functions[_youtube-dl] )) && compdef yt2mp3=youtube-dl
(( $+commands[mx] )) && compdef '_mx' mx
(( $+commands[op] )) && eval "$(op completion zsh)" && compdef _op op
(( $+functions[_chezmoi] )) && compdef cz=chezmoi

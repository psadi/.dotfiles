# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et

# Aliases
# ---------------------------------------------
alias reload='source ~/.zshenv'
alias ..='cd ..'
alias ~="cd ~"

alias grep="grep --color=auto"
alias lzd=lazydocker
alias pip3="python3 -m pip"
alias py="python3"
alias pip="pip3"
alias ssh="TERM=xterm-256color ssh"

alias cpf=copyfile
alias cpd=copydir

alias path='echo -e ${PATH//:/\\n}'
alias ldpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
alias rm='rm -i'
alias mkdir='mkdir -pv'

alias yayf="yay -Slq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S"

# Suffix Aliases
alias -s sh="${EDITOR}"
alias -s py="${EDITOR}"
alias -s zig="${EDITOR}"
alias -s go="${EDITOR}"
alias -s zsh="${EDITOR}"
alias -s md="bat"
alias -s json="jless"
alias -s yaml="bat"
alias -s toml="bat"

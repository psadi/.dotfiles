#!/usr/bin/env zsh
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et

# Aliases
#---------------------------------------------
alias reload='source ~/.zprofile'
alias ..='cd ..'
alias ~="cd ~"

alias grep="grep --color=auto"
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

# Load Zap
#---------------------------------------------
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] \
    && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# Plugins
#---------------------------------------------
plug "Aloxaf/fzf-tab"
plug "mroth/evalcache"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"

# Load evals, aliases, functions & commands
#---------------------------------------------
for z (${ZDOTDIR}/misc/**/*(N.)) plug $z

# Tidying User Path
# ---------------------------------------------
typeset -U path cdpath fpath manpath

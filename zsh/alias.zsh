#!/usr/bin/env zsh
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et

alias reload='source ~/.zshrc'
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
alias rm='rm -i'
alias mkdir='mkdir -pv'

alias ls="ls --color=auto"
alias ll="ls -l -go"
alias la="ll -a"
alias lrth="ll -rth"
alias larth="la -rth"

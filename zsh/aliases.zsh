#!/bin/sh

alias reload='source ~/.zshrc'
alias ..='cd ..'
alias ~="cd ~"

alias ls='exa'
alias ll='ls -l'
alias la='ls -la'
alias lrth='ls -l --sort modified'
alias lt="ls --tree"
alias lzd=lazydocker

# history control
alias h='history'
alias hs='history | grep'
alias hsi='history | grep -i'

alias zj=zellij

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

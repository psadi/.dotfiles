#!/bin/sh

if [ -d '/home/linuxbrew/.linuxbrew' ];
then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

eval "$(starship init zsh)"
# export PS1='%F{blue}%~ %(?.%F{green}.%F{red})%#%f '
eval "$(zoxide init zsh)"
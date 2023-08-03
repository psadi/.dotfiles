#!/bin/sh

if [ -d '/home/linuxbrew/.linuxbrew' ];
then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
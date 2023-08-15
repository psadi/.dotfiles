#!/bin/sh

if [ -d '/home/linuxbrew/.linuxbrew' ];
then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# export PS1='%F{blue}%~ %(?.%F{green}.%F{red})%#%f '

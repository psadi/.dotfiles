#!/usr/bin/env zsh

if ! command -v 'which bat' &> /dev/null
then
    alias cat='bat -p'
    export MANPAGER='bat'
fi

if ! type "hx --version" > /dev/null; then
  export EDITOR=hx
	export editor=hx
fi

if [ -d "$HOME/.cargo" ]
then
	source "$HOME/.cargo/env"
fi
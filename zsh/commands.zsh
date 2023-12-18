#!/bin/sh

if ! command -v 'which bat' &> /dev/null
then
    alias cat='bat -p'
    export MANPAGER='bat'
fi

if [ -d "$HOME/.cargo" ]
then
	source "$HOME/.cargo/env"
fi

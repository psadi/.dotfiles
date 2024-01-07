#!/usr/bin/env zsh

if [ -d "$HOME/.cargo" ]
then
	source "$HOME/.cargo/env"
fi

if command -v bat &> /dev/null; then
  alias cat="bat -p"
  export MANPAGER="bat"
fi

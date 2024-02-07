#!/usr/bin/env zsh

if [ -d "$HOME/.cargo" ]
then
	source "$HOME/.cargo/env"
fi

if command -v bat &> /dev/null; then
  alias cat="bat -p"
  export MANPAGER="bat"
fi

if command -v eza &> /dev/null; then
  alias ls='eza'
  alias ll='eza -l'
  alias la='eza -la'
  alias lrth='eza -l --sort modified'
  alias lt="eza --tree"
fi

if [ -d /opt/pkg/nvim-linux64 ]; then
  export PATH=$PATH:/opt/pkg/nvim-linux64/bin
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/pkg/nvim-linux64/lib
  export MANPATH=$MANPATH:/opt/pkg/nvim-linux64/man
fi

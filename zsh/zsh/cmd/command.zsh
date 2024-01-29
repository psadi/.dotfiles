#!/usr/bin/env zsh

if [ -d "$HOME/.cargo" ]
then
	source "$HOME/.cargo/env"
fi

if command -v bat &> /dev/null; then
  alias cat="bat -p"
  export MANPAGER="bat"
fi

if [ -d /opt/nvim-linux64 ]; then
  export PATH=$PATH:/opt/nvim-linux64/bin
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/nvim-linux64/lib
  export MANPATH=$MANPATH:/opt/nvim-linux64/man
fi

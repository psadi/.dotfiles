#!/usr/bin/env zsh

if command -v bat &> /dev/null; then
  alias cat="bat -p"
  export MANPAGER="bat"
fi

if command -v k9s &> /dev/null; then
  alias k9s="k9s --logoless --headless --readonly --crumbsless"
fi

if [ -d /opt/pkg/nvim-linux64 ]; then
  export PATH=$PATH:/opt/pkg/nvim-linux64/bin
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/pkg/nvim-linux64/lib
  export MANPATH=$MANPATH:/opt/pkg/nvim-linux64/man
  alias vim="nvim"
fi

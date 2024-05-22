#!/usr/bin/env zsh

if command -v bat &> /dev/null; then
  alias cat="bat -p"
  export MANPAGER="bat"
fi

if command -v k9s &> /dev/null; then
  alias k9s="k9s --logoless --headless --readonly --crumbsless"
fi

if command -v nvim &> /dev/null; then
  export EDITOR=nvim
  alias vim="nvim"
fi

if [ -d "${HOME}/go/bin" ];
then
  export PATH="${HOME}/go/bin:${PATH}"
fi;

if [ -f "${HOME}/.cargo/env" ];
then
  . "$HOME/.cargo/env"
fi;

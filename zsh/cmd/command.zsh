#!/usr/bin/env zsh

if command -v bat &> /dev/null; then
  alias cat="bat -p"
  export MANPAGER="bat"
fi

if command -v k9s &> /dev/null; then
  alias k9s="k9s --logoless --headless --readonly --crumbsless"
fi

case "${OSTYPE}" in
  "Linux")
    export NVIM_PACKAGE_NAME="nvim-linux64"
    ;;
  "Darwin")
    export NVIM_PACKAGE_NAME="nvim-macos"
esac

if [ -d "/opt/pkg/${NVIM_PACKAGE_NAME}" ]; then
  export PATH="${PATH}:/opt/pkg/${NVIM_PACKAGE_NAME}/bin"
  export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/opt/pkg/${NVIM_PACKAGE_NAME}/lib"
  export MANPATH="${MANPATH}:/opt/pkg/${NVIM_PACKAGE_NAME}/share/man"
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

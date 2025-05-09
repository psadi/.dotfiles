#!/usr/bin/env zsh
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et

export OSTYPE=$(uname -s | tr '[:upper:]' '[:lower:]')
export DOTFILES_DIR="${HOME}/.dotfiles"

export PATH="${PATH}:${HOME}/.local/bin"

if [ -d "${HOME}/.cargo" ]; then
    source "$HOME/.cargo/env"
fi

opt_path="$HOME/.local/opt"
opt_pkgs=(
  "amazon-corretto-21.0.7.6.1-linux-x64"
  "groovy-4.0.26"
)

for pkg in "${opt_pkgs[@]}"; do
    pkg_path="${opt_path}/${pkg}"
    export PATH="${PATH}:${pkg_path}/bin"
    export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${pkg_path}/lib"
    export MANPATH="${MANPATH}:${pkg_path}/share/man"
done

#!/usr/bin/env zsh
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et

# Base
#---------------------------------------------
export OSTYPE=$(uname -s | tr '[:upper:]' '[:lower:]')
export DOTFILES_DIR="${HOME}/.dotfiles"

if [ -f "${HOME}/.cargo/env" ]; then
  source "${HOME}/.cargo/env"
fi

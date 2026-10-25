#!/usr/bin/env zsh
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et

# zmodload zsh/zprof

export OSTYPE=$(uname -s | tr '[:upper:]' '[:lower:]')
export DOTFILES_DIR="${HOME}/.dotfiles"
export ZDOTDIR="${HOME}/.config/zsh"

# XDG base directories (also provided by environment.d for the graphical session)
export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
export XDG_DATA_DIRS="${XDG_DATA_DIRS:-${XDG_DATA_HOME}:/usr/local/share:/usr/share}"

export ZSH_COMPLETION_DUMP="${HOME}/.cache/zsh/.zcompdump"
export ZSH_COMPDUMP="${ZSH_COMPLETION_DUMP}"

export LD_LIBRARY_PATH="${HOME}/.local/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"
. "$HOME/.cargo/env"

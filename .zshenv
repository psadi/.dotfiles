#!/usr/bin/env zsh
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et

export OSTYPE=$(uname -s | tr '[:upper:]' '[:lower:]')
export DOTFILES_DIR="${HOME}/.dotfiles"
export ZDOTDIR="${HOME}/.config/zsh"
export ZSH_COMPLETION_DUMP="${HOME}/.cache/zsh/.zcompdump"

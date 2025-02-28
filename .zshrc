#!/usr/bin/env zsh
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et

# Base
#---------------------------------------------
export OSTYPE=$(uname -s | tr '[:upper:]' '[:lower:]')
export DOTFILES_DIR="${HOME}/.dotfiles"

# Load Zap
#---------------------------------------------
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] \
    && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# Plugins
#---------------------------------------------
plug "Aloxaf/fzf-tab"
plug "mroth/evalcache"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"

# Load evals, aliases, functions & commands
#---------------------------------------------
for z (${DOTFILES_DIR}/zsh/**/*(N.)) plug $z

# Tidying User Path
# ---------------------------------------------
typeset -U path cdpath fpath manpath
autoload bashcompinit
bashcompinit
source "/home/adithyaps/.local/share/bash-completion/completions/am"

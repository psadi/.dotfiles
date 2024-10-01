#!/usr/bin/env zsh
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et

#---------------------------------------------
#      _       _    __ _ _
#     | |     | |  / _(_) |
#   __| | ___ | |_| |_ _| | ___  ___
#  / _` |/ _ \| __|  _| | |/ _ \/ __|
# | (_| | (_) | |_| | | | |  __/\__ \
#  \__,_|\___/ \__|_| |_|_|\___||___/
#---------------------------------------------
# name   : P S, Adithya
# email  : therealslimaddy@duck.com
#---------------------------------------------

# P10K Instant Prompt
#---------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set Path Dynamically
#---------------------------------------------
function pathman() {
  local var_name="$1"
  local new_dir="$2"

  eval "val=\$$var_name"

  case ":$val:" in
    *":$new_dir:"*) ;;
    *) eval "$var_name=\"$new_dir:\$$var_name\"" ;;
  esac
}

# Set Language
#---------------------------------------------
export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# Set Base Config
#---------------------------------------------
export OSTYPE=$(uname -s | tr '[:upper:]' '[:lower:]')
export DOTFILES_DIR="${HOME}/.dotfiles"

# Load Zap
#---------------------------------------------
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] \
    && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# Plugins
plug "romkatv/powerlevel10k"
plug "romkatv/gitstatus"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "Aloxaf/fzf-tab"
plug "mroth/evalcache"

# Load evals, aliases, functions & commands
#---------------------------------------------
for z (${DOTFILES_DIR}/zsh/**/*(N.)) plug $z

# Set ZSH Prompt
#---------------------------------------------
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Tidying User Path
# ---------------------------------------------
typeset -U path cdpath fpath manpath

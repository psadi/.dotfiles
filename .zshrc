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
# email  : ps.adithya@icloud.com
#---------------------------------------------

# Enable Powerlevel10k instant prompt.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

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

# Set Base Config
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
# plug "romkatv/powerlevel10k"

# Load evals, aliases, functions & commands
#---------------------------------------------
for z (${DOTFILES_DIR}/zsh/**/*(N.)) plug $z

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Tidying User Path
# ---------------------------------------------
typeset -U path cdpath fpath manpath

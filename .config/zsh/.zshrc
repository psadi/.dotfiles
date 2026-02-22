#!/usr/bin/env zsh
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et

# Instant Prompt
# ---------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load Zap
#---------------------------------------------
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] \
    && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# Plugins
#---------------------------------------------
plug "mattmc3/ez-compinit"
plug "Aloxaf/fzf-tab"
plug "mroth/evalcache"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "romkatv/powerlevel10k"

# Load evals, functions & commands
#---------------------------------------------
for z (${ZDOTDIR}/misc/**/*(N.)) plug $z

# Tidying User Path
# ---------------------------------------------
typeset -U path cdpath fpath manpath

# Prompt
# ---------------------------------------------
[[ ! -f "${ZDOTDIR}/.p10k.zsh" ]] || source "${ZDOTDIR}/.p10k.zsh"

# Completions
autoload -Uz compinit bashcompinit zmv
compinit -u -d "${ZSH_COMPLETION_DUMP}"
bashcompinit

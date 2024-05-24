#!/bin/sh

#---------------------------------------------
#
#      _       _    __ _ _
#     | |     | |  / _(_) |
#   __| | ___ | |_| |_ _| | ___  ___
#  / _` |/ _ \| __|  _| | |/ _ \/ __|
# | (_| | (_) | |_| | | | |  __/\__ \
#  \__,_|\___/ \__|_| |_|_|\___||___/
#
#---------------------------------------------
#
# name   : P S, Adithya
# email  : ps.adithya@icloud.com
#
#---------------------------------------------

# p10k instant prompt
#---------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Bindkeys
#---------------------------------------------
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
#---------------------------------------------
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase

# Set Opts
#---------------------------------------------
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt hist_save_by_copy
setopt hist_verify
setopt NO_CASE_GLOB
setopt AUTO_CD
setopt interactivecomments
unsetopt BEEP

# Set Language
#---------------------------------------------
export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# Set Base Config
#---------------------------------------------
export SHELL=$(which zsh)
export OSTYPE=$(uname -a | awk '{print $1}')
export CLICOLOR=1
export TERM=xterm-256color
export DOTFILES="${HOME}/dotfiles"
export ZSH_DOTFILES_DIR="${DOTFILES}/zsh"
export ZSH_CMD_PATH="${ZSH_DOTFILES_DIR}/cmd"
export ZSH_PLUGINS_PATH="${ZSH_DOTFILES_DIR}/plugins"

# ls/completion colors
#---------------------------------------------
export LS_COLORS='ow=36:di=34:fi=32:ex=31:ln=35:'

# Man pager
#---------------------------------------------
export LESS_TERMCAP_md=$'\e[32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[100;37m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[34m'
export GROFF_NO_SGR=1

# Load Zap
#---------------------------------------------
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
#plug "sindresorhus/pure"
plug "romkatv/powerlevel10k"
plug "zsh-users/zsh-completions"
plug "Aloxaf/fzf-tab"

# Load and initialise completion system
#---------------------------------------------
autoload -Uz compinit
compinit

# Load (evals,aliases,functions) & plugins
#---------------------------------------------
for z (${ZSH_CMD_PATH}/**/*(N.)) plug $z
for z (${ZSH_PLUGINS_PATH}/**/*(N.)) plug $z

# ZStyle
#---------------------------------------------
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' switch-group '<' '>'

# PYTHON
#---------------------------------------------
PYTHON_VERSION='python@3.12'
export PYTHON_HOME="$(brew --prefix ${PYTHON_VERSION})"
export PYTHONUSERBASE="${HOME}/.local"
export PIP_USE_DEPRICATED=html5lib

# PATH
#---------------------------------------------
PATH="${HOME}/.local/bin:${PYTHON_HOME}/libexec/bin:/usr/local/sbin:${PATH}"
export PATH

# Set Zsh Prompt
#---------------------------------------------
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#---------------------------------------------
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

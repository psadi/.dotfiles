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

# PATH
#---------------------------------------------
PATH="${HOME}/.local/bin:${PYTHON_HOME}/libexec/bin:/usr/local/sbin:${PATH}"
export PATH

# Set Language
#---------------------------------------------
export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# Set Base Config
#---------------------------------------------
export OSTYPE=$(uname -a | awk '{print $1}')
export DOTFILES="${HOME}/dotfiles"
export ZSH_CONFIG_DIR="${DOTFILES}/zsh"

# Load Zap
#---------------------------------------------
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] \
    && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

plug "psadi/zap-prompt"
plug "psadi/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-completions"
plug "Aloxaf/fzf-tab"

# Load and initialise completion system
#---------------------------------------------
autoload -Uz compinit
compinit

# Load evals,aliases, functions, plugins & completions
#---------------------------------------------
for z (${ZSH_CONFIG_DIR}/**/*(N.)) plug $z

# ZStyle
#---------------------------------------------
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' switch-group '<' '>'


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
export SHELL=$(which zsh)
export OSTYPE=$(uname -a | awk '{print $1}')
export CLICOLOR=1
export TERM=xterm-256color
export DOTFILES="${HOME}/dotfiles"
export ZSH_DOTFILES_DIR="${DOTFILES}/zsh"
export ZSH_CMD_PATH="${ZSH_DOTFILES_DIR}/cmd"
export ZSH_PLUGINS_PATH="${ZSH_DOTFILES_DIR}/plugins"

# Load Zap
#---------------------------------------------
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

plug "psadi/zap-prompt"
plug "psadi/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-completions"
plug "Aloxaf/fzf-tab"
#plug "romkatv/powerlevel10k"

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
if command -v brew &> /dev/null; then
  PYTHON_VERSION='python@3.12'
  export PYTHON_HOME="$(brew --prefix ${PYTHON_VERSION})"
  export PYTHONUSERBASE="${HOME}/.local"
  export PIP_USE_DEPRICATED=html5lib
fi

# To customize prompt, run `p10k configure` or edit ~/dotfiles/.p10k.zsh.
[[ ! -f ~/dotfiles/.p10k.zsh ]] || source ~/dotfiles/.p10k.zsh

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

# Set Opts
#---------------------------------------------
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
setopt APPEND_HISTORY
setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_BY_COPY
setopt HIST_VERIFY
setopt SHARE_HISTORY
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
export ZSH_DOTFILES_DIR="${HOME}/dotfiles/zsh"
export ZSH_CMD_PATH="${ZSH_DOTFILES_DIR}/zsh/cmd"
export TOOLS_PATH="${HOME}/.local/opt/tools"
export _ZSH_CONFIG_PATH="${ZSH_DOTFILES_DIR}/zsh"
export _ZSH_PLUGINS_PATH="${_ZSH_CONFIG_PATH}/plugins"
export _ZSH_COMPLETIONS_PATH="${_ZSH_CONFIG_PATH}/completions"

# ls/completion colors
export LS_COLORS='ow=36:di=34:fi=32:ex=31:ln=35:'

# History
export HISTFILE=$HOME/.zsh_history
export SAVEHIST=1000000
export HISTSIZE=1000000

# Manpages
export LESS_TERMCAP_md=$'\e[32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[100;37m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[34m'
export GROFF_NO_SGR=1

# Load Plug
#---------------------------------------------
source "${_ZSH_CONFIG_PATH}/Plug.zsh"

# Load Commands
#---------------------------------------------
for z (${ZSH_CMD_PATH}/**/*(N.)) plug $z
source "${ZSH_DOTFILES_DIR}/${OSTYPE}.zshrc"

# Load Plugins
#---------------------------------------------

for z in `ls ${_ZSH_PLUGINS_PATH}`;
do
  plug "${_ZSH_PLUGINS_PATH}/${z}";
done

# Zsh Completions + Keybindings
#---------------------------------------------
plug ${_ZSH_COMPLETIONS_PATH}/completions.zsh

# Load Tools
#---------------------------------------------
type LoadTools &>/dev/null && LoadTools || true

# Set Zsh Prompt
#---------------------------------------------
export PURE_PROMPT_SYMBOL="Σ"
fpath+=("${_ZSH_CONFIG_PATH}/pure")
autoload -U promptinit; promptinit
prompt pure

#!/usr/bin/env zsh
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et

# Soar
#---------------------------------------------
if (( $+commands[soar] )); then
  PATH="${PATH}:${HOME}/.local/share/soar/bin"
fi

# evalcache
#---------------------------------------------
if (( $+functions[_evalcache] )); then
  _evalcache fzf --zsh
  _evalcache zoxide init zsh
  _evalcache starship init zsh
  _evalcache uv generate-shell-completion zsh
fi

# Bottom
#---------------------------------------------
if (( $+commands[btm] )); then
  alias htop="btm -b"
fi

# Bat
#---------------------------------------------
if (( $+commands[bat] )); then
  alias cat="bat -p"
  export MANPAGER="bat -l man -p"
  export MANROFFOPT='-c'
  export BAT_THEME="tokyonight_night"
fi

# Eza
#---------------------------------------------
if (( $+commands[eza] )); then
  alias ls='eza --no-filesize --no-time --git'
  alias ll='ls -l'
  alias la="ll -a"
  alias lt="ll --tree --level=2"
  export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
else
  alias ls="ls --color=auto"
  alias ll="ls -l -go"
  alias la="ll -a"
  alias lrth="ll -rth"
  alias larth="la -rth"
fi

# Zoxide
#---------------------------------------------
if (( $+commands[zoxide] )); then
  alias cd="z"
fi

# K9s
#---------------------------------------------
if (( $+commands[k9s] )); then
  alias k9s="k9s --logoless --headless --readonly --crumbsless"
fi

# Neovim
# ---------------------------------------------
if (( $+commands[nvim])); then
  export EDITOR=nvim
  alias vim="nvim"
  alias vi="nvim"
  alias v="nvim"
fi

# FZF
# ---------------------------------------------
if (( $+commands[fzf] )); then
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none
  --color=bg+:#283457 \
  --color=bg:#16161e \
  --color=border:#27a1b9 \
  --color=fg:#c0caf5 \
  --color=gutter:#16161e \
  --color=header:#ff9e64 \
  --color=hl+:#2ac3de \
  --color=hl:#2ac3de \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#2ac3de \
  --color=query:#c0caf5:regular \
  --color=scrollbar:#27a1b9 \
  --color=separator:#ff9e64 \
  --color=spinner:#ff007c \
"
fi

# Yazi
# ---------------------------------------------
if (( $+commands[yazi])); then
  alias yz=yazi
fi
#
# pfetch
# ---------------------------------------------
if (( $+commands[pfetch])); then
  pfetch
fi
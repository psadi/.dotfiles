#!/usr/bin/env zsh
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et

# evalcache
#---------------------------------------------
if (( $+functions[_evalcache] )); then
  _evalcache fzf --zsh
  _evalcache zoxide init zsh
  _evalcache uv generate-shell-completion zsh
fi

# Bat
#---------------------------------------------
if (( $+commands[bat] )); then
  alias cat="bat -p"
  export MANPAGER="bat"
  export MANROFFOPT='-c'
  export BAT_THEME="base16"
fi

# Eza
#---------------------------------------------
if (( $+commands[eza] )); then
  alias ls='eza --no-filesize --no-time --git --hyperlink'
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
  --border=none \
"
fi

# Yazi
# ---------------------------------------------
if (( $+commands[yazi])); then
  alias yz=yazi
fi

# AppMan
# ---------------------------------------------
if (( $+commands[appman])); then
  autoload bashcompinit
  bashcompinit
  source "${HOME}/.local/share/bash-completion/completions/appman"
fi

# Zed
# ---------------------------------------------
if (( $+commands[zeditor] )); then
  alias zed="zeditor"
fi

#!/usr/bin/env zsh
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et

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
  export BAT_THEME="base16"
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

# Homebrew
#---------------------------------------------
if (( $+commands[brew] )); then
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_UPGRADE_GREEDY=1
  export HOMEBREW_NO_AUTO_UPDATE=1
  # Python
  PYTHON_VERSION='python@3.12'
  export PYTHON_HOME="$(brew --prefix ${PYTHON_VERSION})"
  export PYTHONUSERBASE="${HOME}/.local"
  export PIP_USE_DEPRICATED=html5lib
  # Path
  pathman PATH "${PYTHON_HOME}/libexec/bin"
  pathman PATH "/usr/local/sbin"
  pathman PATH "/usr/local/opt/m4/bin"
fi

# Optional Packages
# ---------------------------------------------
for dir in /opt/pkg/*; do
  if [ -d "$dir" ]; then
    if [ -d "${dir}/bin" ]; then
      pathman PATH "${dir}/bin"
    else
      pathman PATH "${dir}"
    fi
    pathman LD_LIBRARY_PATH "${dir}/lib"
    pathman MANPATH "${dir}/share/man"
  fi
done

# Neovim
# ---------------------------------------------
if (( $+commands[nvim])); then
  export EDITOR=nvim
  alias vim="nvim"
  alias vi="nvim"
  alias v="nvim"
fi

if (( $+commands[neovide] )); then
  alias nv="neovide"
fi


# Docker
# ---------------------------------------------
function doco() {
    local context
    context=$(docker context ls -q | fzf --exit-0 --layout reverse --border rounded --height 20 --preview="docker context inspect {1} --format '{{json .}}' | jq -C")

    if [ -n "$context" ]; then
        docker context use "$context"
    else
        echo "No context selected."
    fi
}


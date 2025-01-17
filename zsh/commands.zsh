#!/usr/bin/env zsh
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et


# Soar
#---------------------------------------------
if (( $+commands[soar] )); then
  pathman PATH "${HOME}/.local/share/soar/bin"
fi

# evalcache
#---------------------------------------------
if (( $+functions[_evalcache] )); then
  [[ $OSTYPE == "linux" ]] && _evalcache /home/linuxbrew/.linuxbrew/bin/brew shellenv
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

# Homebrew
#---------------------------------------------
if (( $+commands[brew] )); then
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_UPGRADE_GREEDY=1
  export HOMEBREW_NO_AUTO_UPDATE=1
  # Python
  if [ $OSTYPE = "darwin" ]; then
    PYTHON_VERSION='python@3.12'
    export PYTHON_HOME="$(brew --prefix ${PYTHON_VERSION})"
    export PYTHONUSERBASE="${HOME}/.local"
    export PIP_USE_DEPRICATED=html5lib
    pathman PATH "${PYTHON_HOME}/libexec/bin"
    pathman PATH "/usr/local/sbin"
  fi
fi

#asdf
#---------------------------------------------
if (( $+commands[asdf] )); then
 source $(brew --prefix asdf)/libexec/asdf.sh
fi

# Optional Packages
# ---------------------------------------------
if [ -d /opt/pkg/*(/) ]; then
  for dir in /opt/pkg/*; do
    if [ -d "$dir" ]; then
      if [ -d "${dir}/bin" ]; then
        pathman PATH "${dir}/bin"
      else
        pathman PATH "${dir}"
      fi
      [[ -d "${dir}/lib" ]] && pathman LD_LIBRARY_PATH "${dir}/lib"
      [[ -d "${dir}/share/man" ]] && pathman MANPATH "${dir}/share/man"
    fi
  done
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
# Yazi
# ---------------------------------------------
if (( $+commands[pfetch])); then
  export PF_INFO="ascii title os host kernel uptime memory"

fi


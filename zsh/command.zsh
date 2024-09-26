#!/usr/bin/env zsh
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et

# Bat
#---------------------------------------------
if (( $+commands[bat] )); then
  alias cat="bat -p"
  export MANPAGER="bat"
  export MANROFFOPT='-c'
  export BAT_THEME="ansi"
fi

# Zoxide
#---------------------------------------------
if (( $+commands[zoxide] )); then
  alias cd="z"
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


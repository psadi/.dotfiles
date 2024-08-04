#!/usr/bin/env zsh

if (( $+commands[bat] )); then
  alias cat="bat -p"
  export MANPAGER="bat"
  export BAT_THEME="Visual Studio Dark+"
  show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
  export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
fi

if (( $+commands[k9s] )); then
  alias k9s="k9s --logoless --headless --readonly --crumbsless"
fi

if (( $+commands[eza] )); then
  alias ls='eza --group-directories-first --icons'
  alias ll='ls -lh --git'
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

if (( $+commands[zoxide] )); then
  alias cd="z"
fi

# PYTHON
#---------------------------------------------
if (( $+commands[brew] )); then
  PYTHON_VERSION='python@3.12'
  export PYTHON_HOME="$(brew --prefix ${PYTHON_VERSION})"
  export PYTHONUSERBASE="${HOME}/.local"
  export PIP_USE_DEPRICATED=html5lib
fi

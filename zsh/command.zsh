#!/usr/bin/env zsh

if (( $+commands[bat] )); then
  alias cat="bat -p"
  export MANPAGER="bat"
  export BAT_THEME="ansi"
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

# Optional Packages
# ---------------------------------------------
for dir in /opt/pkg/*; do
  if [ -d "$dir" ]; then
    export PATH="${PATH}:${dir}/bin"
    export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${dir}/lib"
    export MANPATH="${MANPATH}:${dir}/share/man"
  fi
done

if (( $+commands[nvim])); then
  export EDITOR=nvim
  alias vim="nvim"
fi


if (( $+commands[wezterm])); then
  wz(){
    case "${1}" in
    ls) wezterm cli list ;;
    lsc) wezterm cli list-clients ;;
    *) wezterm "${2}" --help ;;
    esac
  }
fi

if (( $+commands[zellij])); then
  zj() {
    in_zj() {
      [ -n "$ZELLIJ" ] || { echo "Not in a Zellij session"; return 1; }
    }

    case "${1}" in
      rt)
        in_zj || return $?
        zellij action rename-tab "${2:-$(basename "$PWD")}"
        ;;
      rp|rs)
        in_zj || return $?
        [ -z "${2}" ] && { echo "$0 $1: Name required"; return 1; }
        zellij action rename-${1#r} "${2}"
        ;;
      *)
        if [ -z "${1}" ]; then
            zellij -s "$(basename "$PWD")"
        else
            zellij "$@"
        fi
        ;;
    esac
  }
fi

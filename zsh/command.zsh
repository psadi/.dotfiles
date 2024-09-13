#!/usr/bin/env zsh

# Bat
#---------------------------------------------
if (( $+commands[bat] )); then
  alias cat="bat -p"
  export MANPAGER="bat"
  # export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export MANROFFOPT='-c'
  export BAT_THEME="ansi"
  show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
  export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
fi

# K9s
#---------------------------------------------
if (( $+commands[k9s] )); then
  alias k9s="k9s --logoless --headless --readonly --crumbsless"
fi

# Eza
#---------------------------------------------
if (( $+commands[eza] )); then
  alias ls='eza --group-directories-first --icons'
  alias ll='ls -lh --git'
  alias la="ll -a"
  alias lt="ll --tree --level=2"
  export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
else # fallback 
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

# Homebrew
#---------------------------------------------
if (( $+commands[brew] )); then
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
    pathman PATH "${dir}/bin"
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


# Wezterm
# ---------------------------------------------
if (( $+commands[wezterm])); then
  wz(){
    case "${1}" in
    ls) wezterm cli list ;;
    lsc) wezterm cli list-clients ;;
    *) wezterm "${2}" --help ;;
    esac
  }
fi


# Emacs
# ---------------------------------------------

if (( $+commands[emacs] )); then
  pathman PATH "${HOME}/.config/emacs/bin"
  alias emacs="emacs -nw"

  if [[ $OSTYPE == "darwin" && ! -d "/Applications/Emacs.app" && -d "/usr/local/Cellar/emacs-plus@29/29.4/Emacs.app/Contents/MacOS" ]]; then
    ln -s /usr/local/Cellar/emacs-plus@29/29.4/Emacs.app /Applications/Emacs.app
  fi
fi

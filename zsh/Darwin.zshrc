#!/bin/sh

# evals
source "${ZSH_DOTFILES_DIR}/evals.zsh"

# functions
source "${ZSH_DOTFILES_DIR}/functions.zsh"

# Set aliases and exports based on package availability
source "${ZSH_DOTFILES_DIR}/commands.zsh"

# aliases
source "${ZSH_DOTFILES_DIR}/aliases.zsh"

# exports
export PYTHONPATH="$(brew --prefix python@3.11)"
export PYTHONUSERBASE="${HOME}/.local"
export GROOVY_HOME=/Users/adithyaps/opt/groovy-4.0.8
export M2_HOME=/Users/adithyaps/opt/apache-maven-3.8.7
export GOBIN="/Users/adithyaps/go/bin"
export PATH="${GOBIN}:${HOME}/.local/bin:${PYTHONPATH}/bin:${HOME}/go/bin:${GROOVY_HOME}/bin:${M2_HOME}/bin:${HOME}/.docker/bin:${PATH}"

if [ -d "${HOME}/.config/emacs/bin" ]; then
  export PATH="${HOME}/.config/emacs/bin:${PATH}"
fi

if [ -S "/Users/adithyaps/.local/share/containers/podman/machine/qemu/podman.sock" ]; then
  export DOCKER_HOST='unix:///Users/adithyaps/.local/share/containers/podman/machine/qemu/podman.sock'
fi
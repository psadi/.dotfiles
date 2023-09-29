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
export GOBIN="/Users/adithyaps/go/bin"
export PATH="${GOBIN}:${HOME}/.local/bin:${PYTHONPATH}/bin:${HOME}/go/bin:${HOME}/.docker/bin:${PATH}"
export DOCKER_HOST="tcp://192.168.1.100:2375"
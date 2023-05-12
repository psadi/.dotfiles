#!/bin/sh

# evals
source "${ZSH_DOTFILES_DIR}/evals.zsh"

# functions
source "${ZSH_DOTFILES_DIR}/functions.zsh"

# Set aliases and exports based on package availability
source "${ZSH_DOTFILES_DIR}/commands.zsh"

# aliases
source "${ZSH_DOTFILES_DIR}/aliases.zsh"

# export
# python
export PYTHONPATH="$(brew --prefix python@3.11)"
export PYTHONUSERBASE="${HOME}/.local"
if [ -n "$PYTHONPATH" ]; then
    export PYTHONPATH='/usr/local/lib/python3.11/site-packages/pdm/pep582':$PYTHONPATH
else
    export PYTHONPATH='/usr/local/lib/python3.11/site-packages/pdm/pep582'
fi


export GROOVY_HOME=/Users/adithyaps/opt/groovy-4.0.8
export M2_HOME=/Users/adithyaps/opt/apache-maven-3.8.7
export PATH="${HOME}/.local/bin:${PYTHONPATH}/bin:${HOME}/go/bin:${GROOVY_HOME}/bin:${M2_HOME}/bin:${HOME}/opt/v:${PATH}"

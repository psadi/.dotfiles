#!/bin/sh

# HOMEBREW
#---------
export HOMEBREW_NO_ENV_HINTS
# export HOMEBREW_CASK_OPTS="--appdir=${HOME}/Desktop/Applications"

# PYTHON
#--------
PYTHON_VERSION='python@3.12'
export PYTHON_HOME="$(brew --prefix ${PYTHON_VERSION})"
export PYTHONUSERBASE="${HOME}/.local"
export PIP_USE_DEPRICATED=html5lib

# CORE-UTILS
#-----------
export COREUTILS=${HOME}/.local/opt/homebrew/opt/coreutils/libexec/gnubin
export LD_LIBRARY_PATH=${OPENSSL_PATH}/lib:${GLIB_PATH}/lib:${LD_LIBRARY_PATH}
export LDFLAGS="-L ${OPENSSL_PATH}/lib -Wl,-rpath,${OPENSSL_PATH}/lib"

PATH="${HOME}/.local/bin:${COREUTILS}:${PYTHON_HOME}/libexec/bin:/usr/local/sbin:${PATH}"
export PATH

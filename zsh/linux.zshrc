#!/bin/sh 

# evals
source "${ZSH_DOTFILES_DIR}/.evals"

# functions
source "${ZSH_DOTFILES_DIR}/.functions"

# aliases
alias m='micro'
alias nala='sudo nala'
source "${ZSH_DOTFILES_DIR}/.aliases"

export LOCAL_DIR=/home/psadi/.local
export OPT_PATH=/opt
export EXTMOUNT=/media/tb-vol
export PATH=$LOCAL_DIR/bin:$HOME/.local/platform-tools:$PATH

# Auto source available languages
if [ -d '/opt/lang' ];then
    for lang in $(ls /opt/lang);
    do
        export PATH=/opt/lang/${lang}/bin:$PATH
	      export LD_LIBRARY_PATH=/opt/lang/$lang/lib:$LD_LIBRARY_PATH
    done

    export PATH
fi

if [ -d "${HOME}/Android" ];then
  export ANDROID_HOME="${HOME}/Android"
  export PATH="${ANDROID_HOME}/Sdk/cmdline-tools/latest/bin:${PATH}"
	export LD_LIBRARY_PATH="${ANDROID_HOME}/Sdk/cmdline-tools/latest/lib:${LD_LIBRARY_PATH}"
fi

if [ -d "/opt/chrome-linux" ]; then
  export CHROME_EXECUTABLE="/opt/chrome-linux/chrome"
  export PATH="/opt/chrome-linux:${PATH}"
fi

# Set aliases and exports based on package availability
source "${ZSH_DOTFILES_DIR}/.commands"

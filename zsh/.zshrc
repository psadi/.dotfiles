########################################################
#                      _ _
#  _ __  ___  __ _  __| (_)
# | '_ \/ __|/ _` |/ _` | |
# | |_) \__ \ (_| | (_| | |
# | .__/|___/\__,_|\__,_|_|
# |_|
## Name   : P S, Adithya
## email  : adithya3494@gmail.com
## gitlab : https://github.com/psadi
########################################################

# functions
dotpush(){
	cwd=$PWD
	
	cd /media/tb-vol/workspace/dotfiles
	git add . && git commit -am "$(date "+%Y-%m-%d %H:%M:%S") dotfiles updates" && git push
	cd $cwd
}
# aliases
alias reload='source ~/.zshrc'
alias ..='cd ..'
alias ~="cd ~"

# z jumparound -  https://github.com/rupa/z
export _Z_DATA=${HOME}/.zsh/z/data
. ${HOME}/.zsh/z/z.sh

# exports

if ! command -v 'bat --version' &> /dev/null # setting bat as default manpager if exists
then
    export MANPAGER='bat'
fi

#history control
alias h='history'
alias hs='history | grep'
alias hsi='history | grep -i'

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# zsh plguins
source "${HOME}/.zsh/_zsh.zsh"

autoload -Uz compinit
zstyle ':completion:*' menu select
#fpath+=~/.zfunc

export LOCAL_DIR=/home/psadi/.local
export EXTMOUNT=/media/tb-vol
export GOBIN=$EXTMOUNT/workspace/go/bin
export GOPATH=$EXTMOUNT/workspace/go
export PATH=$LOCAL_DIR/bin:$LOCAL_DIR/opt/go/bin:$LOCAL_DIR/opt/node/bin:$PATH


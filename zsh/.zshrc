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

# prompt
eval "$(starship init zsh)"

# functions
dotpush(){
	cd /tb-vol/workspace/dotfiles
	git add . && git commit -am "$(date "+%Y-%m-%d %H:%M:%S") dotfiles updates" && git push
	cd -
}

lg()
{
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

# aliases
alias nala='sudo nala'
alias reload='source ~/.zshrc'
alias ..='cd ..'
alias ~="cd ~"

alias ls='exa'
alias ll='ls -l'
alias la='ls -la'
alias lrth='ls -l --sort modified'
alias lt="ls --tree"
alias lzd=lazydocker

# z jumparound -  https://github.com/rupa/z
export _Z_DATA=${HOME}/.zsh/z/data
. ${HOME}/.zsh/z/z.sh


# history control
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
export OPT_PATH=/opt
export EXTMOUNT=/media/tb-vol
export PATH=$LOCAL_DIR/bin:$HOME/.emacs.d/bin:$PATH

# Auto source available languages
if [ -d '/opt/lang' ];then
	for lang in $(ls /opt/lang);
	do
		export PATH=/opt/lang/${lang}/bin:$PATH
	done

	export PATH
fi

# Set aliases and exports based on package availability
if ! command -v 'bat --version' &> /dev/null # setting bat as default manpager if exists
then
    alias cat='bat -p'
    export MANPAGER='bat'
fi

if ! command -v 'nvim --version' &> /dev/null
then
    alias vim='nvim'
    alias vi='nvim' 
fi
if ! command -v 'go version' &>/dev/null
then
	export GOPATH=$HOME/workspace/go
	export GOBIN=$HOME/workspace/go/bin
	export PATH=$GOBIN:$PATH
fi

if ! command -v 'which pfetch' &>/dev/null
then
	clear
	pfetch
fi

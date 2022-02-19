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

# lazygit - https://github.com/jesseduffield/lazygit
lg()
{
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

.push(){
    cd /media/tb-vol/workspace/dotfiles
    git add .
    git commit --amend --no-edit && git push -f
    cd -
}

# aliases
alias sc=shellcheck
alias pdm=podman
alias ls='exa'
alias l='exa -1'
alias ll='exa -l'
alias la='exa -la'
alias ld='lazydocker'
alias lt='exa --tree --icons'
alias lrth='exa -l --sort modified --icons'
alias reload='source ~/.zshrc'
alias cat='bat -p'
alias ..='cd ..'
alias ~="cd ~"
alias pip=pip3
alias emacs="emacsclient -c -a 'emacs'"

# fzf - https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# z jumparound -  https://github.com/rupa/z

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

autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

export GOBIN='/usr/local/go/bin'
export GOPATH='/home/psadi/workspace/go'
export PATH="$HOME/.local/bin:$HOME/.emacs.d/bin:$GOBIN:$PATH"

eval "$(starship init zsh)"

# zsh plguin
source "${HOME}/.zsh/plugins/zsh-plugins.zsh"

# z
export _Z_DATA=${HOME}/.zsh/z/data
. ${HOME}/.zsh/z/z.sh
source $HOME/.cargo/env


# bun completions
[ -s "/home/psadi/.bun/_bun" ] && source "/home/psadi/.bun/_bun"

# Bun
export BUN_INSTALL="/home/psadi/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export lang=en_us.utf-8

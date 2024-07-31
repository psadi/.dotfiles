#!/usr/bin/env zsh

.p(){
    cd ${ZSH_CONFIG_DIR}
    git add . && git commit -am "$(date "+%Y-%m-%d %H:%M:%S") dotfiles updates" && git push
    cd -
}

p.(){
    cd ${ZSH_CONFIG_DIR}
    git pull --rebase origin master
    cd -
}

lg(){
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

unsetp(){
    export http_proxy=
    export https_proxy=
    export no_proxy=
    export HTTP_PROXY=
    export HTTPS_PROXY=
    export NO_PROXY=
}

setp(){
    export http_proxy=
    export https_proxy=
    export no_proxy=

    export HTTP_PROXY="${http_proxy}"
    export HTTPS_PROXY="${https_proxy}"
    export NO_PROXY="${no_proxy}"
}

show-proxy(){
    echo "http proxy :: ${http_proxy}"
    echo "https proxy :: ${https_proxy}"
    echo "no proxy :: ${no_proxy}"
}

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

autotune()
{
    chmod -R 755 *
    fd -t f -X dos2unix
    git grep -I --name-only -z -e '' | xargs -0 sed -i 's/[ \t]\+\(\r\?\)$/\1/'
}

gitlfs()
{
    git rev-list --objects --all |
        git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' |
        sed -n 's/^blob //p' |
        sort --numeric-sort --key=2 |
        cut -c 1-12,41- |
        $(command -v gnumfmt || echo numfmt) --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest
}

procs() {
    if [ "${2}" != '--no-wrap' ]; then
        tput rmam
    fi

    ps -ef | grep -i "${1}" | grep -v grep | awk '{printf "\033[0;36m%s\033[0m ", $2; for (i=8; i<=NF; i++) {if (i==8) printf "\033[0;33m%s", $i; else printf " %s", $i}; print ""}'

    if [ "${2}" != '--no-wrap' ]; then
        tput smam
    fi
}

brew_leaves_gen(){
    if command -v brew &> /dev/null; then
        brew leaves > "${DOTFILES}/ansible/roles/homebrew/files/brew.leaves"
        brew list --cask -1 > "${DOTFILES}/ansible/roles/homebrew/files/brew.casks"
    else
        echo "homebrew is required to generate leaves"
        return
    fi
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

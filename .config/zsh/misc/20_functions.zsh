#!/usr/bin/env zsh
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et

function mkcd { mkdir "$1" && cd "$1"; }; compdef mkcd=mkdir

function copyfile {
  emulate -L zsh

  clipcopy $1
}

function copydir {
  emulate -L zsh

  print -n $PWD | clipcopy
}

.p(){
    cd ${DOTFILES_DIR}
    git add . && git commit -m ".dotfiles update" && git push --force-with-lease
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

show-proxy(){
    echo "http proxy :: ${http_proxy}"
    echo "https proxy :: ${https_proxy}"
    echo "no proxy :: ${no_proxy}"
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

# Battery
# ---------------------------------------------
function bstat() {
    find /sys/class/power_supply/BAT0/* -type f | fzf --exit-0 --layout reverse --border rounded --height 20 --preview 'cat {}'
}

fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for\!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

evalcache(){
  case "${1}" in
    zoxide) _evalcache zoxide init zsh ;;
    fzf) _evalcache fzf --zsh ;;
    uv) _evalcache uv generate-shell-completion zsh ;;
    mise) _evalcache mise activate zsh ;;
    *) echo "Unknown tool: ${1}" ;;
  esac
}

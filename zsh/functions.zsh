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
    git add . && git commit -am "dotfiles update" && git push
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

gitlfs()
{
    git rev-list --objects --all |
        git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' |
        sed -n 's/^blob //p' |
        sort --numeric-sort --key=2 |
        cut -c 1-12,41- |
        $(command -v gnumfmt || echo numfmt) --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest
}

# procs() {
#     if [ "${2}" != '--no-wrap' ]; then
#         tput rmam
#     fi
#
#     ps -ef | grep -i "${1}" | grep -v grep | awk '{printf "\033[0;36m%s\033[0m ", $2; for (i=8; i<=NF; i++) {if (i==8) printf "\033[0;33m%s", $i; else printf " %s", $i}; print ""}'
#
#     if [ "${2}" != '--no-wrap' ]; then
#         tput smam
#     fi
# }

brew_leaves_gen(){
    if command -v brew &> /dev/null; then
        brew leaves > "${DOTFILES_DIR}/ansible/roles/brew/files/brew.${OSTYPE}.leaves"
        [[ $OSTYPE == "darwin" ]] && brew list --cask -1 > "${DOTFILES_DIR}/ansible/roles/homebrew/files/brew.casks"
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

# Docker
# ---------------------------------------------
function doco() {
    local context
    context=$(docker context ls -q | fzf --exit-0 --layout reverse --border rounded --height 20 --preview="docker context inspect {1} --format '{{json .}}' | jq -C")

    if [ -n "$context" ]; then
        docker context use "$context"
    else
        echo "No context selected."
    fi
}

# Battery
# --
function bstat() {
    find /sys/class/power_supply/BAT0/* -type f | fzf --exit-0 --layout reverse --border rounded --height 20 --preview 'cat {}'
}

function clean_old_snaps() {
  LANG=C snap list --all | while read snapname ver rev trk pub notes; do if [[ $notes = *disabled* ]]; then sudo snap remove "$snapname" --revision="$rev"; fi; done
}

function bak(){
  if [ ! -f "/mnt/backup/.backup/backup.sh" ]; then
    echo "Backup Script not found, is 'restic' configured ?"
    return 1
  fi

  _eval_str="sudo restic -r /mnt/backup/backup-psadi-thinkpad --password-file /mnt/backup/.backup/config/backup.secret"
  case $1 in
    list)
      eval ${_eval_str} snapshots
      ;;
    diff)
       eval ${_eval_str} diff $2 $3
      ;;
    forget)
      eval ${_eval_str} forget $2
      ;;
    forget)
      eval ${_eval_str} forget $2
      ;;
    tag)
      eval ${_eval_str} tag --set $2 $3
      ;;
    *)
      shift 1
      # /mnt/backup/.backup/backup.sh "${@}"
      echo $@
      ;;
  esac
}

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

# Backup
# ---------------------------------------------
function restic_backup() {
  local backup_script="/mnt/backup/.backup/backup.sh"
  local restic_repo="/mnt/backup/backup-psadi-thinkpad"
  local password_file="/mnt/backup/.backup/config/backup.secret"

  if [ ! -f "$backup_script" ]; then
    echo "Backup Script not found, is 'restic' configured?"
    return 1
  fi

  local restic_cmd="sudo restic -r $restic_repo --password-file $password_file"

  case $1 in
    backup)
      "$backup_script" --tag manual
      ;;
    list|ls)
      eval "$restic_cmd snapshots"
      ;;
    diff)
      eval "$restic_cmd diff $2 $3"
      ;;
    forget)
      eval "$restic_cmd forget $2"
      ;;
    tag)
      eval "$restic_cmd tag --set $2 $3"
      ;;
    restore)
      eval "$restic_cmd restore --target / $2"
      ;;
    unlock)
      eval "$restic_cmd unlock"
      ;;
    *)
      echo "${0}: no argument provided"
      return 1
      ;;
  esac
}

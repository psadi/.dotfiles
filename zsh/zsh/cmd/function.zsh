#!/usr/bin/env zsh

.p(){
    cd ${ZSH_DOTFILES_DIR}
    git add . && git commit -am "$(date "+%Y-%m-%d %H:%M:%S") dotfiles updates" && git push
    cd -
}

p.(){
    cd ${ZSH_DOTFILES_DIR}
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

zj(){

  in_zj(){
    if [ -z $ZELLIJ ]; then
      "Not in a Zellij session"
      return 1
    fi
  }

  case "${1}" in
    rt)
      in_zj || return $?
      if [ -z "${2}" ]; then
        zellij action rename-tab $(basename $PWD)
      else
        zellij action rename-tab "${2}"
      fi
    ;;
    rp)
      in_zj || return $?
      if [ -z "${2}" ]; then
        echo "${0}, ${1}: Pane name required";
        return 1
      else
        zellij action rename-pane "${2}";
      fi
    ;;
    rs)
      in_zj || return $?
      if [ -z "${2}" ]; then
        echo "${0}, ${1}: Session name required";
        return 1
      else
        zellij action rename-session "${2}";
      fi
    ;;
    *)
      if [ -z "${1}" ]; then
        zellij -s "$(basename ${PWD})";
      else
        zellij "${@}";
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

clone(){
    if [ -z $1 ]; then
        echo "$0 : url is required to clone"
        return 1
    fi
    git clone $1 && cd $(basename $1) && code -a .
}

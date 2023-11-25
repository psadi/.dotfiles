#!/bin/sh

.p(){
    cd ${ZSH_DOTFILES_DIR}
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

zj(){
    zellij -s "$(basename $PWD)"
}


lxl(){
    if [ -f "/Applications/Lite XL.app/Contents/MacOS/lite-xl" ]; then
        "/Applications/Lite XL.app/Contents/MacOS/lite-xl" &
    fi
}


function mkcd {
  last=$(eval "echo \$$#")
  if [ ! -n "$last" ]; then
    echo "Enter a directory name"
  elif [ -d $last ]; then
    echo "\`$last' already exists"
  else
    mkdir $@ && cd $last
  fi
}

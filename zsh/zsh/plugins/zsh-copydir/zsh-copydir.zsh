# Copies the pathname of the current directory to the system or X Windows clipboard
function copydir {
  emulate -L zsh

  case $OSTYPE in
    "Linux") print -n $PWD | clipcopy ;;
    "Darwin") print -n $PWD | pbcopy ;;
    *) echo "unsupported ostype" ;;
  esac
}

alias cpd=copydir

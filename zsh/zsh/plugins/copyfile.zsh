# Copies the contents of a given file to the system or X Windows clipboard
#
# copyfile <file>
function copyfile {
  emulate -L zsh
  case ${OSTYPE} in
    "Linux") clipcopy $1 ;;
    "Darwin") cat $1 | pbcopy ;;
    *) echo "unsupported ostype" ;;
  esac
}

alias cpf=copyfile

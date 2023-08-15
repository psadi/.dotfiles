# Copies the contents of a given file to the system or X Windows clipboard
#
# copyfile <file>
function copyfile {
  emulate -L zsh
  case "$(uname -a | awk '{print $1}')" in
    "Linux") clipcopy $1 ;;
    "Darwin") cat $1 | pbcopy ;;
    *) echo "unsupported ostype" ;;
  esac
    # clipcopy $1
}

alias cpf=copyfile

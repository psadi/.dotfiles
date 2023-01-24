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

ZSH_DOTFILES_DIR="${HOME}/workspace/dotfiles/zsh"
OSTYPE=$(uname -a | awk '{print $1}')
export EDITOR=hx

case "${OSTYPE}" in
  "Linux") source "${ZSH_DOTFILES_DIR}/.zshrc_linux" ;;
  "Darwin") source "${ZSH_DOTFILES_DIR}/.zshrc_osx" ;;
  *) echo "unsupported ostype" ;;
esac

source "${ZSH_DOTFILES_DIR}/.zsh/_zsh.zsh"


ZSH_FZF_PATH="${PLUGINS_DIRECTORY}/zsh-fzf"

# Auto Completions 
# ----------------
[[ $- == *i* ]] && source "${ZSH_FZF_PATH}/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "${ZSH_FZF_PATH}/key-bindings.zsh"


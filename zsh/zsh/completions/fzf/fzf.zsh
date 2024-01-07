
export FZF_COMPLETION_TRIGGER=',,'

# Auto Completions
# ----------------
[[ $- == *i* ]] && source "${_ZSH_COMPLETIONS_PATH}/fzf/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "${_ZSH_COMPLETIONS_PATH}/fzf/key-bindings.zsh"


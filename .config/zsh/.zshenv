# Zsh reads this file instead of ~/.zshenv when ZDOTDIR is already exported.
# Keep a single source of truth in ~/.zshenv.
[[ -r "${HOME}/.zshenv" ]] && source "${HOME}/.zshenv"

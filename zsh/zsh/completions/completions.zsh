# Zsh Completions + Keybindings
#---------------------------------------------
autoload -Uz compinit
compinit

to_fpath(){
  fpath=($_ZSH_COMPLETIONS_PATH/$1 $fpath)
}

for z in `find ${_ZSH_COMPLETIONS_PATH} -mindepth 1 -type d -exec basename {} \;`;
do
  source "${_ZSH_COMPLETIONS_PATH}/${z}/${z}.zsh";
done;

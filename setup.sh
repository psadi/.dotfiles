#!/bin/sh

DOTFILES_REPO_PATH="${HOME}/workspace/dotfiles"
CONFIG_PATH="${HOME}/.config"

# Symlink Config Files

cd ${CONFIG_PATH}
printf "Linking Config for Alacritty ... \n"
ln -s ${DOTFILE_REPO_PATH}/alacritty
printf "Linking Config for Helix ... \n"
ln -s ${DOTFILE_REPO_PATH}/helix
printf "Linking Config for Starship ... \n"
ln -s ${DOTFILE_REPO_PATH}/starship/starship.toml
printf "Linking Config for Zsh ... \n"
ln -s ${DOTFILE_REPO_PATH}/zsh/zshrc .zshrc

cd ${HOME}
printf "Linking Config for Git ... \n"
ln -s ${DOTFILES_REPO_PATH}/git/.gitconfig
printf "Linking Config for Tmux ... \n"
ln -s ${DOTFILES_REPO_PATH}/tmux/tmux.conf .tmux.conf

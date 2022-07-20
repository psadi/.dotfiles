#!/usr/bin/env zsh

PLUGINS_DIRECTORY="${HOME}/.zsh/plugins"

for z in `ls "${PLUGINS_DIRECTORY}"`;
do
	if [ -d "${PLUGINS_DIRECTORY}/${z}" ];
	then
		source "${PLUGINS_DIRECTORY}/${z}/${z}.zsh"
	fi
done

source /home/psadi/.zsh/plugins/zsh-fzf/zsh-fzf.zsh

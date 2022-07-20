#!/usr/bin/env zsh

PLUGINS_DIRECTORY="${HOME}/.zsh/plugins"

if [ -d "${PLUGINS_DIRECTORY}/zsh-defer" ];
then
	autoload -Uz "${PLUGINS_DIRECTORY}/zsh-defer/zsh-defer"
fi

for z in `ls "${PLUGINS_DIRECTORY}" | grep -v 'zsh-defer'`;
do
	if [ -d "${PLUGINS_DIRECTORY}/${z}" ];
	then
		zsh-defer source "${PLUGINS_DIRECTORY}/${z}/${z}.zsh"
	fi
done

source /home/psadi/.zsh/plugins/zsh-fzf/zsh-fzf.zsh

#!/usr/bin/env zsh

PLUGINS_DIRECTORY="${HOME}/.zsh/plugins"

for z in `ls "${PLUGINS_DIRECTORY}"`;
do
	if [ -d "${PLUGINS_DIRECTORY}/${z}" ];
	then
		source "${PLUGINS_DIRECTORY}/$z/$z.zsh"
	fi
done

if [ $? -eq 0 ];
then
	alias cpf=copyfile
	alias cpd=copydir
else
	echo "error sourcing zsh plugins"
	exit 1
fi


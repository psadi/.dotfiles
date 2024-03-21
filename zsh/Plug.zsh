#!/usr/bin/env zsh

# this file is responsible to load all zsh plugins dynamically
# inside $_ZSH_PLUGIN_DIR
# Source Credit: https://github.com/zap-zsh/zap/blob/master/zap.zsh
# I'm Just re-using the plugin load and plugins list capability from the framework

export -a INSTALLED_PLUGINS=()

function plug() {

    function _try_source() {
        local -a initfiles=(
            $plugin_dir/${plugin_name}.{plugin.,}{z,}sh{-theme,}(N)
            $plugin_dir/*.{plugin.,}{z,}sh{-theme,}(N)
        )
        (( $#initfiles )) && source $initfiles[1]
    }

    # If the absolute is a directory then source as a local plugin
    local plugin_absolute="${1:A}"
    if [ -d "${plugin_absolute}" ]; then
        local plugin="${plugin_absolute}"
        local plugin_name="${plugin:t}"
        local plugin_dir="${plugin_absolute}"
    else
        # If the basename directory exists, then local source only
        if [ -d "${plugin_absolute:h}" ]; then
            [[ -f "${plugin_absolute}" ]] && source "${plugin_absolute}"
            return
        fi

        local plugin="$1"
        local plugin_name="${plugin:t}"
        local plugin_dir="$_ZSH_PLUGIN_DIR/$plugin_name"
    fi

    _try_source && { INSTALLED_PLUGINS+="$plugin_name" && return 0 } || echo "❌ $plugin_name not activated" && return 1
}


function lsplug() {
    local _plugin
    echo "Plugins List:"
    echo "------- ----\n"
    for _plugin in ${INSTALLED_PLUGINS[@]}; do
        printf '%4s  🔌 %s\n' $INSTALLED_PLUGINS[(Ie)$_plugin] $_plugin
    done
}

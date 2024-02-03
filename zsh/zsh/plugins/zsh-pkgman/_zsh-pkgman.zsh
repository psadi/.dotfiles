#!/usr/bin/env zsh

function LanguageExporter {
    case "${1}" in
        "java")
            [[ "${OSTYPE}" = "Linux" ]]; export JAVA_HOME="${TOOLS_PATH}/${1}/this";
            [[ "${OSTYPE}" = "Darwin" ]]; \
                export JAVA_HOME="${TOOLS_PATH}/${1}/this/Contents/Home" && \
                export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${JAVA_HOME}/lib";
            export PATH="${PATH}:${JAVA_HOME}/bin"
        ;;
        "maven")
            export M2_HOME="${TOOLS_PATH}/${1}/this"
        ;;
        "groovy") export GROOVY_HOME="${TOOLS_PATH}/${1}/this" ;;
        "node") export NODE_HOME="${TOOLS_PATH}/${1}/this" ;;
        "gradle") export GRADLE_HOME="${TOOLS_PATH}/${1}/this" ;;
        "go")
            export GOROOT="${TOOLS_PATH}/${1}/this/bin"
            export GOBIN="${HOME}/go/bin"
        ;;
        "liquibase") export LIQUIBASE_HOME="${TOOLS_PATH}/${1}/this" ;;
        # "v") export PATH="${TOOLS_PATH}/${1}:${PATH}" ;;
        # "bfg") export PATH="${TOOLS_PATH}/${1}:${PATH}" ;;
        *)
          [[ -d "${TOOLS_PATH}/${1}/this/bin" ]]  && export PATH="${TOOLS_PATH}/${1}/this/bin:${PATH}"
          [[ ! -d "${TOOLS_PATH}/${1}/this/bin" ]]  && export PATH="${TOOLS_PATH}/${1}/this:${PATH}"
          [[ ! -d "${TOOLS_PATH}/${1}/this" ]]  && export PATH="${TOOLS_PATH}/${1}:${PATH}"
        ;;
    esac
}

function PackageManager {

    if type "fzf --version" > /dev/null; then
        echo "fzf not found, PackageManager won't work :X"
        return
    fi

    TOOL=$(find ${TOOLS_PATH} -maxdepth 1 -type d -print | cut -d '/' -f7 | fzf --height=15% --reverse)
    SELECTED_TOOL=$(find ${TOOLS_PATH}/${TOOL} -maxdepth 1 -type d -print | cut -d '/' -f8 | fzf --height=15% --reverse)
    if [ ! -z "${SELECTED_TOOL}" ]; then
        THIS_PRESENT=$(find ${TOOLS_PATH}/${TOOL} -maxdepth 1 -type l -print | cut -d '/' -f8)
        [[ "${THIS_PRESENT}" == "this" ]] \
        && [[ -d "${TOOLS_PATH}/${TOOL}/${SELECTED_TOOL}" ]] \
        && unlink "${TOOLS_PATH}/${TOOL}/this"

        ln -s "${TOOLS_PATH}/${TOOL}/${SELECTED_TOOL}" "${TOOLS_PATH}/${TOOL}/this" \
        && reload || source ~/.zshrc
    fi
}

function LoadTools {
    load_tool(){
        is_this_present=$(find ${TOOLS_PATH}/${1} -maxdepth 1 -type l -print | cut -d '/' -f8)
        [[ "${is_this_present}" == "this" ]] \
            && [[ -d "${TOOLS_PATH}/${1}/this/bin" ]] && export PATH="${PATH}:${TOOLS_PATH}/${1}/this/bin" \
            && [[ -d "${TOOLS_PATH}/${1}/this/lib" ]] && export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${TOOLS_PATH}/${1}/this/lib"

        [[ "${is_this_present}" == "this" ]]; LanguageExporter "${1}";
    }
    if [ -d "${TOOLS_PATH}" ];then
        for tool in $(ls "${TOOLS_PATH}" );
        do
            load_tool "${tool}"
        done
    fi
}

reset_tools(){
    if [ -d "${TOOLS_PATH}" ];then
        for tool in $(ls "${TOOLS_PATH}" );
        do
            unlink "${TOOLS_PATH}/${tool}/this"
        done
    fi
}

pkg(){
    PackageManager
}

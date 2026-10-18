#!/bin/sh
# Set the Linux TTY palette to Kanagawa.
# ly's `bg` only colors the dialog box; the screen background is TTY color 0.
# This runs via `start_cmd` in config.ini, before ly takes over the VT.
if [ "${TERM:-linux}" = "linux" ]; then
    BLACK="1f1f28"
    DARK_RED="c34043"
    DARK_GREEN="76946a"
    DARK_YELLOW="c0a36e"
    DARK_BLUE="7e9cd8"
    DARK_MAGENTA="957fb8"
    DARK_CYAN="6a9589"
    LIGHT_GRAY="c8c093"
    DARK_GRAY="727169"
    RED="e46876"
    GREEN="98bb6c"
    YELLOW="e6c384"
    BLUE="7fb4ca"
    MAGENTA="957fb8"
    CYAN="7aa89f"
    WHITE="dcd7ba"

    COLORS="$BLACK $DARK_RED $DARK_GREEN $DARK_YELLOW $DARK_BLUE $DARK_MAGENTA $DARK_CYAN $LIGHT_GRAY $DARK_GRAY $RED $GREEN $YELLOW $BLUE $MAGENTA $CYAN $WHITE"

    i=0
    while [ "$i" -lt 16 ]; do
        printf '\033]P%x%s' "$i" "$(echo "$COLORS" | cut -d ' ' -f$((i + 1)))"
        i=$((i + 1))
    done

    clear
fi

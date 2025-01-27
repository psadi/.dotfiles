# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et

function detect-clipboard() {
  emulate -L zsh

  if [[ "${OSTYPE}" == darwin* ]] && (( ${+commands[pbcopy]} )) && (( ${+commands[pbpaste]} )); then
    clipcopy() { cat "${1:-/dev/stdin}" | pbcopy; }
    clippaste() { pbpaste; }

  elif [[ "${OSTYPE}" == (cygwin|msys)* ]]; then
    clipcopy() { cat "${1:-/dev/stdin}" > /dev/clipboard; }
    clippaste() { cat /dev/clipboard; }

  elif (( $+commands[clip.exe] )) && (( $+commands[powershell.exe] )); then
    clipcopy() { cat "${1:-/dev/stdin}" | clip.exe; }
    clippaste() { powershell.exe -noprofile -command Get-Clipboard; }

  elif [ -n "${WAYLAND_DISPLAY:-}" ] && (( ${+commands[wl-copy]} )) && (( ${+commands[wl-paste]} )); then
    clipcopy() { cat "${1:-/dev/stdin}" | wl-copy &>/dev/null; }
    clippaste() { wl-paste --no-newline; }

  elif [ -n "${DISPLAY:-}" ] && (( ${+commands[xsel]} )); then
    clipcopy() { cat "${1:-/dev/stdin}" | xsel --clipboard --input; }
    clippaste() { xsel --clipboard --output; }

  elif [ -n "${DISPLAY:-}" ] && (( ${+commands[xclip]} )); then
    clipcopy() { cat "${1:-/dev/stdin}" | xclip -selection clipboard -in &>/dev/null; }
    clippaste() { xclip -out -selection clipboard; }

  elif (( ${+commands[lemonade]} )); then
    clipcopy() { cat "${1:-/dev/stdin}" | lemonade copy; }
    clippaste() { lemonade paste; }

  elif (( ${+commands[doitclient]} )); then
    clipcopy() { cat "${1:-/dev/stdin}" | doitclient wclip; }
    clippaste() { doitclient wclip -r; }

  elif (( ${+commands[win32yank]} )); then
    clipcopy() { cat "${1:-/dev/stdin}" | win32yank -i; }
    clippaste() { win32yank -o; }

  elif [[ $OSTYPE == linux-android* ]] && (( $+commands[termux-clipboard-set] )); then
    clipcopy() { cat "${1:-/dev/stdin}" | termux-clipboard-set; }
    clippaste() { termux-clipboard-get; }

  elif [ -n "${TMUX:-}" ] && (( ${+commands[tmux]} )); then
    clipcopy() { tmux load-buffer "${1:--}"; }
    clippaste() { tmux save-buffer -; }

  else
    function _retry_clipboard_detection_or_fail() {
      local clipcmd="${1}"; shift
      if detect-clipboard; then
        "${clipcmd}" "$@"
      else
        print "${clipcmd}: Platform $OSTYPE not supported or dependencies are not installed" >&2
        return 1
      fi
    }

    clipcopy() { _retry_clipboard_detection_or_fail clipcopy "$@"; }
    clippaste() { _retry_clipboard_detection_or_fail clippaste "$@"; }
    return 1
  fi
}

function clipcopy clippaste {
  unfunction clipcopy clippaste
  detect-clipboard || true
  "$0" "$@"
}

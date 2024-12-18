#!/usr/bin/env zsh
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et

_evalcache /home/linuxbrew/.linuxbrew/bin/brew shellenv
_evalcache fzf --zsh
_evalcache zoxide init zsh
_evalcache starship init zsh
_evalcache uv generate-shell-completion zsh

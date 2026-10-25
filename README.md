# psadi/.dotfiles

Niri (Wayland) desktop for Arch/CachyOS — Kanagawa theme, Geist fonts, Waybar,
fuzzel, foot, PCManFM, and a repo-only package set (no AUR).

## Bootstrap

```sh
git clone https://github.com/psadi/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

`bootstrap.sh` installs packages from `packages.json` with `pacman`, installs Geist
and GeistMono Nerd Font from their upstream releases, applies the Kanagawa theme,
and links the dotfiles with GNU Stow.

Key binds: `Super+Enter` opens foot, `Super+Shift+N` opens PCManFM, `Super+Escape`
opens the niri menu.

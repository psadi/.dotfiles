# psadi/.dotfiles

Niri (Wayland) desktop for Arch/CachyOS — Kanagawa theme, Geist fonts, Waybar,
fuzzel, foot, Nautilus, Docker for containers, and the AUR via paru.

## Bootstrap

```sh
git clone https://github.com/psadi/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

`bootstrap.sh` installs packages from `packages.json` with `pacman`, bootstraps
`paru` and installs the `aur` packages, enables Docker, installs Geist and
GeistMono Nerd Font from their upstream releases, applies the Kanagawa theme,
and links the dotfiles with GNU Stow.

Key binds: `Super+Enter` opens foot, `Super+Shift+N` opens Nautilus, `Super+Escape`
opens the niri menu.

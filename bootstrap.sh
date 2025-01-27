#!/usr/bin/env bash
# vim: ft=bash sw=2 ts=2 et

set -euox pipefail

export HISTIGNORE='*sudo -S*'

echo "Bootstrapping your system"

# Validate sudo access
read -rs -p "Enter your sudo password (for installing base packages): " SUDO_PASSWORD
echo "${SUDO_PASSWORD}" | sudo -S -v &>/dev/null || {
  echo "Error: Invalid sudo password or no sudo privileges."
  exit 1
}

doas() {
  echo "${SUDO_PASSWORD}" | sudo -S "${@}"
}

install_yay() {
  doas pacman -S --needed --noconfirm git base-devel
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  (cd /tmp/yay && makepkg -si --noconfirm)
  rm -rf /tmp/yay
}

install_python_deps() {
  echo "Installing Python3 Dependencies"
  python3 -m pip install --upgrade --no-cache-dir --break-system-packages --no-warn-script-location pip ansible jmespath pynvim librosa
}

install_os_deps() {
  if ! command -v yay &>/dev/null; then
    install_yay
  fi

  local install_pkgs=(
  bat bind citron dnsmasq dos2unix eza fd fzf ghostty
  git-delta github-cli vivaldi lazygit libvirt man-db neovim
  networkmanager nodejs noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
  npm podman python-pip qemu-desktop ripgrep snapper stow unzip uv virt-manager
  wl-clipboard xsel yazi zoxide zsh hyperfine
 )
 local remove_pkgs=(
   gnome-contacts gnome-maps gnome-music epiphany gnome-tour gnome-terminal
  )
  doas yay -Sy --noconfirm --needed --quiet "${install_pkgs[@]}"
  doas yay -R --noconfirm "${remove_pkgs[@]}" || true
  doas yay -S --noconfirm --clean
}

clone_dotfiles() {
  local DOTFILES_DIR="${HOME}/.dotfiles"
  if [[ -d "${DOTFILES_DIR}" ]]; then
    echo "Updating psadi/.dotfiles"
    (cd "${DOTFILES_DIR}" && git pull)
  else
    echo "Cloning psadi/.dotfiles"
    git clone https://github.com/psadi/.dotfiles.git "${DOTFILES_DIR}"
  fi
}

configure_user_shell() {
  doas chsh -s /usr/bin/zsh "${USER}"
}

configure_systemd_services() {
  local services=(
    bluetooth
    NetworkManager
    libvirtd
    snapper-backup.timer
    snapper-cleanup.timer
    snapper-boot.timer
  )
  for service in "${services[@]}"; do
    doas systemctl enable "${service}" || true
  done

  echo 'firewall_backend = "iptables"' | sudo tee /etc/libvirt/network.conf
}

install_zap() {
  if [[ -f "${HOME}/.local/share/zap/zap.zsh" ]]; then
    echo "Zap is already installed."
    return
  fi

  echo "Installing Zap Zsh plugin manager..."
  zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
  rm -f ~/.zshrc
}

configure_font() {
  if [ ! -d "${HOME}/.local/share/fonts" ]; then
    mkdir -p "${HOME}/.local/share/fonts"
  fi

  local font_url="https://raw.githubusercontent.com/psadi/MonoLisa-NerdFont/refs/heads/main/Patched/MonoLisaNerdFont"

  for font in Bold.ttf BoldItalic.ttf Italic.ttf Regular.ttf; do
    if [ ! -f "${HOME}/.local/share/fonts/MonoLisaNerdFont-${font}" ]; then
      wget -q "${font_url}-${font}" -O "${HOME}/.local/share/fonts/MonoLisaNerdFont-${font}"
      fc-cache -f -v "${HOME}/.local/share/fonts"
    fi
  done

}

configure_theme() {
  mkdir -p "${HOME}/.local/share/themes"
  mkdir -p "${HOME}/.local/share/icons"

  local theme_url="https://github.com/Fausto-Korpsvart/Tokyonight-GTK-Theme/archive/refs/heads/master.zip"
  local cursor_url="https://github.com/ful1e5/banana-cursor/releases/download/v2.0.0/Banana.tar.xz"

  if [ ! -d "${HOME}/.local/share/themes/Tokyonight-Dark" ]; then
    echo "Configuring Theme..."
    wget -q "${theme_url}" -O /tmp/Tokyonight-GTK-Theme-master.zip
    unzip -q /tmp/Tokyonight-GTK-Theme-master.zip -d /tmp
    (
      cd /tmp/Tokyonight-GTK-Theme-master/themes
      chmod +x install.sh
      ./install.sh -c dark -l --tweaks macos -d "${HOME}/.local/share/themes"
    )
    rm -rf /tmp/Tokyonight-GTK-Theme-master*
  fi

  if [ ! -d "${HOME}/.local/share/icons/Banana" ]; then
    echo "Configuring Banana Cursor..."
    wget -q "${cursor_url}" -O /tmp/Banana.tar.xz
    tar -xf /tmp/Banana.tar.xz -C "${HOME}/.local/share/icons"
    rm -rf /tmp/Banana.tar.xz
  fi

}

gnome_tweaks(){
  gsettings set org.gnome.desktop.default-applications.terminal exec gnome-terminal
  gsettings set org.gnome.desktop.interface font-name 'Geist 11'
  gsettings set org.gnome.desktop.interface document-font-name 'Geist 11'
  gsettings set org.gnome.desktop.interface monospace-font-name 'GeistMono Nerd Font 11'
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
  gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'
	gsettings set org.gnome.desktop.interface show-battery-percentage true
	gsettings set org.gnome.shell favorite-apps "['org.gnome.Settings.desktop', 'org.gnome.Nautilus.desktop', 'vivaldi.desktop', 'com.mitchellh.ghostty.desktop']"
	gsettings set org.gnome.shell.extensions.user-theme name 'Tokyonight-Dark'
	gsettings set org.gnome.desktop.interface gtk-theme 'Tokyonight-Dark'
	gsettings set org.gnome.desktop.interface cursor-theme 'Banana'
	gnome-extensions enable system-monitor@gnome-shell-extensions.gcampax.github.com
	gnome-extensions enable  user-theme@gnome-shell-extensions.gcampax.github.com
	gsettings set org.gnome.desktop.wm.keybindings close "['<Super><Shift>Q']"
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'ghostty'
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'ghostty'
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Super>Return'
	gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name 'chrome'
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command 'vivaldi'
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding '<Super><Shift>Return'
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ name 'nautilus'
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ command 'nautilus'
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ binding '<Super><Shift>n'
	gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/']"

  # Dconf load
  local DOTFILES_DIR="${HOME}/.dotfiles"
  dconf load /org/gnome/shell/ < "${DOTFILES_DIR}/dconf/shell.dconf"
}

finalize() {
  rm -rf "${HOME}/.profile" "${HOME}/.bash*" || true
  mkdir -p "${HOME}/.config"
  stow -d "${HOME}/.dotfiles" -t "${HOME}" . --adopt
}

# Main execution flow
install_os_deps
install_python_deps
install_zap
configure_user_shell
clone_dotfiles
configure_font
configure_theme
finalize
gnome_tweaks
configure_systemd_services

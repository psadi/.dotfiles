#!/usr/bin/env bash
# vim: ft=bash sw=2 ts=2 et

set -euo pipefail

export HISTIGNORE='*sudo -S*'

echo "Bootstrapping your system"

# Validate sudo access
read -s -p "Enter your sudo password (for installing base packages): " SUDO_PASSWORD
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
    auto-cpufreq bind dnsmasq fd fzf git-delta
    github-cli go lazygit libvirt neovim npm qemu-desktop
    python-pip ghostty networkmanager ripgrep starship stow
    thermald unzip virt-manager wl-clipboard zsh zoxide
    man-db dos2unix firefox uv snapper
  )
  local remove_pkgs=(
    gnome-contacts gnome-maps gnome-music vim epiphany gnome-tour htop
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
    git clone https://github.com/psadi/dotfiles.git "${DOTFILES_DIR}"
  fi
}

configure_user_shell() {
  doas chsh -s /usr/bin/zsh "${USER}"
}

configure_systemd_services() {
  local services=(
    libvirtd
    auto-cpufreq
    thermald
    bluetooth
    NetworkManager
    snapper-backup.timer
    snapper-cleanup.timer
    snapper-boot.timer
  )
  for service in "${services[@]}"; do
    doas systemctl enable --now "${service}"
  done
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

finalize() {
  rm -rf "${HOME}/.profile" "${HOME}/.bash*" || true
  mkdir -p "${HOME}/.config"
  stow -d "${HOME}/.dotfiles" -t "${HOME}" .
}

# Main execution flow
install_os_deps
install_python_deps
install_zap
configure_systemd_services
configure_user_shell
clone_dotfiles
configure_font
configure_theme
finalize

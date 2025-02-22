#!/usr/bin/env bash

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
  python3 -m pip install --upgrade --no-cache-dir --break-system-packages --no-warn-script-location pip ansible jmespath pynvim
}

install_os_deps() {
  if ! command -v yay &>/dev/null; then
    install_yay
  fi

  local install_pkgs=(
    axel auto-cpufreq bat bind dnsmasq eza fd fzf git-delta
    github-cli go lazygit libvirt neovim npm procs qemu-desktop
    noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
    ripgrep restic starship stow thermald unzip virt-manager
    wl-clipboard zsh zoxide man-db dos2unix firefox k9s uv
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
  local services=(libvirtd auto-cpufreq thermald)
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
finalize

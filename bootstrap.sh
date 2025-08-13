#!/usr/bin/env bash
# vim: ft=bash sw=2 ts=2 et

export HISTIGNORE='*sudo -S*'

echo "Bootstrapping your system"

# Validate sudo access
read -rs -p "Enter your sudo password: " SUDO_PASSWORD
echo "${SUDO_PASSWORD}" | sudo -S -v &>/dev/null || {
  echo "Error: Invalid sudo password or no sudo privileges."
  exit 1
}

set -euox pipefail

install_yay() {
  sudo pacman -S --needed --noconfirm git base-devel
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

  yay -Sy --noconfirm --needed --quiet "jq"

  local install_pkgs=$(jq -r '.install | unique | sort | join(" ")' < $HOME/.dotfiles/packages.json)
  local remove_pkgs=$(jq -r '.remove | unique | sort | join(" ")' < $HOME/.dotfiles/packages.json)
  yay -Sy --noconfirm --needed --quiet $install_pkgs
  yay -R --noconfirm $remove_pkgs || true
  yay -S --noconfirm --clean
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
  sudo chsh -s /usr/bin/zsh "${USER}"
}

configure_systemd_services() {
  local services=(
    ufw
    bluetooth
    NetworkManager
    libvirtd
    snapper-backup.timer
    snapper-cleanup.timer
    snapper-boot.timer
  )
  for service in "${services[@]}"; do
    sudo systemctl enable "${service}" || true
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

  local theme_url="https://github.com/Fausto-Korpsvart/Kanagawa-GKT-Theme/archive/refs/heads/master.zip"
  local cursor_url="https://github.com/ful1e5/banana-cursor/releases/download/v2.0.0/Banana.tar.xz"

  if [ ! -d "${HOME}/.local/share/themes/Kanagawa-Dark" ]; then
    echo "Configuring Theme..."
    wget -q "${theme_url}" -O /tmp/Kanagawa-GKT-Theme-main.zip
    unzip -q /tmp/Kanagawa-GKT-Theme-main.zip -d /tmp
    (
      cd /tmp/Kanagawa-GKT-Theme-main/themes
      chmod +x install.sh
      ./install.sh -c dark -l --tweaks macos -d "${HOME}/.local/share/themes"
    )
    rm -rf /tmp/Kanagawa-GKT-Theme-master*
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
	gsettings set org.gnome.shell.extensions.user-theme name 'Kanagawa-Dark'
	gsettings set org.gnome.desktop.interface gtk-theme 'Kanagawa-Dark'
	gsettings set org.gnome.desktop.interface cursor-theme 'Banana'
	gnome-extensions enable system-monitor@gnome-shell-extensions.gcampax.github.com
	gnome-extensions enable  user-theme@gnome-shell-extensions.gcampax.github.com
	gsettings set org.gnome.desktop.wm.keybindings close "['<Super><Shift>Q']"
  gsettings set org.gnome.shell favorite-apps "['org.gnome.Settings.desktop', 'org.gnome.Nautilus.desktop', 'brave.desktop', 'com.mitchellh.ghostty.desktop']"
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'ghostty'
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'ghostty'
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Super>Return'
	gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name 'brave'
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command 'brave'
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding '<Super><Shift>Return'
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ name 'nautilus'
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ command 'nautilus'
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ binding '<Super><Shift>n'
	gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/']"

  # Dconf load
  local DOTFILES_DIR="${HOME}/.dotfiles"
  dconf load /org/gnome/shell/ < "${DOTFILES_DIR}/dconf/shell.dconf"
}

general_system_tweaks() {
  # Reference: https://wiki.cachyos.org/configuration/general_system_tweaks
  # Set CPU governor to powersave
  sudo cpupower frequency-set -g powersave
  # Set energy performance preference to performance if not already set
  if ! grep -q "performance" /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference; then
    echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
  fi
  # Enable AMD P-state if not already active
  if ! grep -q "active" /sys/devices/system/cpu/amd_pstate/status; then
    echo active | sudo tee /sys/devices/system/cpu/amd_pstate/status
  fi
  # Configure split lock mitigation if not already set
  if ! grep -q "kernel.split_lock_mitigate=0" /etc/sysctl.d/99-splitlock.conf; then
    sudo touch /etc/sysctl.d/99-splitlock.conf
    echo 'kernel.split_lock_mitigate=0' | sudo tee /etc/sysctl.d/99-splitlock.conf
  fi
  # Enable RCU lazy mode in boot configuration if not already set
  if ! grep -q 'rcutree.enable_rcu_lazy=1' /etc/sdboot-manage.conf; then
    sudo sed -i '/^LINUX_OPTIONS=/ s/"$/ rcutree.enable_rcu_lazy=1"/' /etc/sdboot-manage.conf
  fi
  sudo gpasswd -a "$USER" realtime
  # Remove immutable attribute from EFI variables
  for var in /sys/firmware/efi/efivars/db-* /sys/firmware/efi/efivars/KEK-*; do
    if lsattr "$var" | awk '{print $1}' | grep -q "i"; then
      sudo chattr -i "$var"
    else
      echo "Immutable attribute already removed for $var"
    fi
  done
}

stow_link() {
  rm -rf "${HOME}/.profile" "${HOME}/.bash*" || true
  mkdir -p "${HOME}/.config"
  stow -d "${HOME}/.dotfiles" -t "${HOME}" . --adopt
}

# Main execution flow
clone_dotfiles
install_os_deps
install_python_deps
install_zap
configure_user_shell
# configure_font
configure_theme
stow_link
gnome_tweaks
configure_systemd_services
general_system_tweaks

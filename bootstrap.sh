#!/usr/bin/env bash
# vim: ft=bash sw=2 ts=2 et

export HISTIGNORE='*sudo -S*'

echo "Bootstrapping your system (niri desktop)"

# Validate sudo access
read -rs -p "Enter your sudo password: " SUDO_PASSWORD
echo "${SUDO_PASSWORD}" | sudo -S -v &>/dev/null || {
  echo "Error: Invalid sudo password or no sudo privileges."
  exit 1
}

set -euox pipefail

install_yay() {
  sudo pacman -S --needed --noconfirm git base-devel
  rm -rf /tmp/yay
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  (cd /tmp/yay && makepkg -si --noconfirm)
  rm -rf /tmp/yay
}

install_python_deps() {
  echo "Installing Python3 Dependencies"
  python3 -m pip install --upgrade --no-cache-dir --break-system-packages --no-warn-script-location pip ansible jmespath pynvim
}

install_mise_deps() {
  echo "Installing mise tools"
  (cd "${HOME}/.dotfiles/.config/mise" && mise install --yes)
}

install_os_deps() {
  if ! command -v yay &>/dev/null; then
    install_yay
  fi

  if ! command -v jq &>/dev/null; then
    yay -Sy --noconfirm --needed --quiet "jq"
  fi

  local install_pkgs=$(jq -r '.yay.install | unique | sort | join(" ")' < "${HOME}/.dotfiles/packages.json")
  # Only remove packages that are actually installed (pacman aborts on missing targets).
  local remove_pkgs=$(jq -r '.yay.remove[]' < "${HOME}/.dotfiles/packages.json" |
    while read -r p; do pacman -Qq "$p" &>/dev/null && printf '%s ' "$p"; done)

  yay -Sy --noconfirm --needed --quiet $install_pkgs
  install_mise_deps
  yay -S --noconfirm --clean
  if [ -n "${remove_pkgs// /}" ]; then
    yay -Rns --noconfirm $remove_pkgs || true
  fi
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
  local system_services=(
    ufw
    bluetooth
    NetworkManager
    tailscaled
    power-profiles-daemon
    snapper-backup.timer
    snapper-cleanup.timer
    snapper-boot.timer
  )

  local user_services=(
    syncthing
    hyprpolkitagent
  )

  for service in "${system_services[@]}"; do
    sudo systemctl enable --now "${service}" || true
  done
  for service in "${user_services[@]}"; do
    systemctl --user enable --now "${service}" || true
  done

  # Enable Fast Connectable for instant Bluetooth reconnection after boot
  if ! grep -q "FastConnectable=true" /etc/bluetooth/main.conf 2>/dev/null; then
    echo "Enabling Bluetooth Fast Connectable..."
    sudo sed -i '/^\[General\]/a FastConnectable=true' /etc/bluetooth/main.conf
    sudo systemctl restart bluetooth
  fi
}

configure_login() {
  # TUI display manager (ly), using the version-controlled config in ~/.config/ly.
  # tty1 conflicts with getty automatically.
  if command -v ly-dm &>/dev/null; then
    echo "Configuring ly login manager"
    sudo mkdir -p /etc/systemd/system/ly@.service.d
    sudo tee /etc/systemd/system/ly@.service.d/override.conf >/dev/null <<EOF
[Service]
ExecStart=
ExecStart=/usr/bin/ly-dm -c ${HOME}/.config/ly
EOF
    sudo systemctl daemon-reload
    sudo systemctl disable gdm 2>/dev/null || true
    sudo systemctl disable 'ly@tty2.service' 2>/dev/null || true
    sudo systemctl enable 'ly@tty1.service' || true
  fi
}

configure_power_key() {
  echo "Configuring power button to open the niri power menu"
  sudo mkdir -p /etc/systemd/logind.conf.d
  printf '[Login]\nHandlePowerKey=ignore\n' | sudo tee /etc/systemd/logind.conf.d/10-power-key.conf >/dev/null
}

install_zap() {
  if [[ -f "${HOME}/.local/share/zap/zap.zsh" ]]; then
    echo "Zap is already installed."
    return
  fi

  echo "Installing Zap Zsh plugin manager..."
  zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
  rm -f ~/.zshrc
  mkdir -p "$HOME/.cache/zsh"
  mkdir -p "$HOME/.local/share/zsh/site-functions"
}

configure_font() {
  if [ ! -d "${HOME}/.local/share/fonts" ]; then
    mkdir -p "${HOME}/.local/share/fonts"
  fi

  local font_url="https://raw.githubusercontent.com/psadi/MonoLisa-NerdFont/refs/heads/main/Patched/MonoLisaNerdFont"

  for font in Bold.ttf BoldItalic.ttf Italic.ttf Regular.ttf; do
    if [ ! -f "${HOME}/.local/share/fonts/MonoLisaNerdFont-${font}" ]; then
      curl -sSL "${font_url}-${font}" -o "${HOME}/.local/share/fonts/MonoLisaNerdFont-${font}"
    fi
  done
  fc-cache -f -v "${HOME}/.local/share/fonts"
}

configure_theme() {
  mkdir -p "${HOME}/.local/share/themes"
  mkdir -p "${HOME}/.local/share/icons"

  local theme_url="https://github.com/Fausto-Korpsvart/Kanagawa-GKT-Theme/archive/refs/heads/master.zip"
  local cursor_url="https://github.com/ful1e5/banana-cursor/releases/download/v2.0.0/Banana.tar.xz"

  # GTK3/GTK4 theme; the -l flag links the GTK4 theme into ~/.config/gtk-4.0
  # so libadwaita/GTK4 apps (and Waybar) pick up Kanagawa too.
  if [ ! -d "${HOME}/.local/share/themes/Kanagawa-Dark" ]; then
    echo "Configuring Theme..."
    curl -sSL "${theme_url}" -o /tmp/Kanagawa-GKT-Theme-main.zip
    unzip -q /tmp/Kanagawa-GKT-Theme-main.zip -d /tmp
    (
      cd /tmp/Kanagawa-GKT-Theme-main/themes
      chmod +x install.sh
      ./install.sh -c dark -l --tweaks macos -d "${HOME}/.local/share/themes"
    )
    rm -rf /tmp/Kanagawa-GKT-Theme-*
  fi

  if [ ! -d "${HOME}/.local/share/icons/Banana" ]; then
    echo "Configuring Banana Cursor..."
    curl -sSL "${cursor_url}" -o /tmp/Banana.tar.xz
    tar -xf /tmp/Banana.tar.xz -C "${HOME}/.local/share/icons"
    rm -rf /tmp/Banana.tar.xz
  fi

  # Legacy cursor search path for apps that don't read XDG_DATA_HOME
  mkdir -p "${HOME}/.icons"
  ln -sfn "${HOME}/.local/share/icons/Banana" "${HOME}/.icons/Banana"
  mkdir -p "${HOME}/.icons/default"
  printf '[Icon Theme]\nInherits=Banana\n' > "${HOME}/.icons/default/index.theme"

  fc-cache -f >/dev/null 2>&1 || true
}

configure_gsettings() {
  # GTK/libadwaita apps (Waybar, zenity, etc.) read these; no GNOME shell needed.
  gsettings set org.gnome.desktop.interface gtk-theme 'Kanagawa-Dark' || true
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' || true
  gsettings set org.gnome.desktop.interface font-name 'Geist 11' || true
  gsettings set org.gnome.desktop.interface document-font-name 'Geist 11' || true
  gsettings set org.gnome.desktop.interface monospace-font-name 'GeistMono Nerd Font 11' || true
  gsettings set org.gnome.desktop.interface cursor-theme 'Banana' || true
  gsettings set org.gnome.desktop.interface show-battery-percentage true || true
  gsettings set org.gnome.desktop.interface icon-theme 'Adwaita' || true
}

configure_default_apps() {
  echo "Configuring default applications"
  xdg-settings set default-web-browser brave-origin.desktop || true
  xdg-mime default brave-origin.desktop x-scheme-handler/http x-scheme-handler/https text/html || true
  # yazi as the folder handler (see .local/share/applications/yazi.desktop)
  xdg-mime default yazi.desktop inode/directory || true
  update-desktop-database "${HOME}/.local/share/applications" 2>/dev/null || true
}

configure_io_scheduler() {
  local rules_file="/etc/udev/rules.d/60-ioschedulers.rules"
  if [ ! -f "$rules_file" ] || ! grep -q "adios" "$rules_file" 2>/dev/null; then
    echo "Configuring ADIOS I/O scheduler via udev..."
    sudo tee "$rules_file" > /dev/null <<'EOF'
# SSDs
ACTION=="add|change", KERNEL=="sd[a-z]*|mmcblk[0-9]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="adios"
# NVMe SSDs
ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="adios"
EOF
    sudo udevadm control --reload-rules
    sudo udevadm trigger
  fi
}

general_system_tweaks() {
  # Reference: https://wiki.cachyos.org/configuration/general_system_tweaks
  sudo cpupower frequency-set -g powersave
  echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
  if ! grep -q "active" /sys/devices/system/cpu/amd_pstate/status 2>/dev/null; then
    echo active | sudo tee /sys/devices/system/cpu/amd_pstate/status
  fi
  if [ ! -f /etc/sysctl.d/99-splitlock.conf ] || ! grep -q "kernel.split_lock_mitigate=0" /etc/sysctl.d/99-splitlock.conf; then
    echo 'kernel.split_lock_mitigate=0' | sudo tee /etc/sysctl.d/99-splitlock.conf
  fi
  if ! grep -q "rcutree.enable_rcu_lazy=1" /proc/cmdline; then
    if [ -f /etc/default/limine ]; then
      echo "Enabling RCU Lazy in /etc/default/limine..."
      sudo sed -i '/^KERNEL_CMDLINE\[default\]/ s/"$/ rcutree.enable_rcu_lazy=1"/' /etc/default/limine
    elif [ -f /etc/kernel/cmdline ]; then
      echo "Enabling RCU Lazy in /etc/kernel/cmdline..."
      echo " rcutree.enable_rcu_lazy=1" | sudo tee -a /etc/kernel/cmdline
    else
      echo "Warning: rcutree.enable_rcu_lazy=1 not in kernel cmdline"
    fi
  fi
  for var in /sys/firmware/efi/efivars/db-* /sys/firmware/efi/efivars/KEK-*; do
    if [ -e "$var" ] && lsattr "$var" 2>/dev/null | awk '{print $1}' | grep -q "i"; then
      sudo chattr -i "$var" 2>/dev/null
    fi
  done
}

stow_link() {
  rm -rf "${HOME}/.profile" "${HOME}/.bash*" || true
  mkdir -p "${HOME}/.config"
  stow -d "${HOME}/.dotfiles" -t "${HOME}" . --adopt
}

configure_fstab() {
  if grep -q "2eacdb10-9d3c-4557-900c-28fbf40281e7" /etc/fstab; then
    echo "fstab entry already exists"
  else
    sudo sed -i 's/compress=zstd:1/compress-force=zstd:2,ssd,discard=async,space_cache=v2/' /etc/fstab
    sudo mkdir -p "/mnt/vol-1"
    sudo chown $USER:$USER "/mnt/vol-1"
    echo "UUID=2eacdb10-9d3c-4557-900c-28fbf40281e7 /mnt/vol-1 btrfs defaults,noatime,compress-force=zstd:2,ssd,discard=async,space_cache=v2 0 0" | sudo tee -a /etc/fstab
    sudo systemctl daemon-reload
    sudo mount -av
  fi
  ln -sf /mnt/vol-1/workspace "$HOME/workspace" 2>/dev/null || true
  ln -sf /mnt/vol-1/Phone "$HOME/Phone" 2>/dev/null || true
}

# Main execution flow
clone_dotfiles
install_os_deps
install_python_deps
install_zap
configure_user_shell
configure_font
configure_theme
configure_gsettings
configure_default_apps
stow_link
configure_login
configure_systemd_services
configure_power_key
configure_io_scheduler
general_system_tweaks
configure_fstab

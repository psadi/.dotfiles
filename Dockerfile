FROM debian:bookworm-slim

COPY . /tmp/dotfiles

# --------------------------
# SETUP
# --------------------------
RUN apt-get update && apt-get upgrade && apt-get install -y \
    build-essential git curl wget axel sudo zsh jq zip unzip \
    python3 python3-pip python3-setuptools python3-wheel && \
    # --------------------------
    # CREATE & CONFIGURE USER
    # --------------------------
    useradd -m -s /usr/bin/zsh -G sudo -u 1000 -U psadi && \
    echo "psadi ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    usermod --password 3494 psadi && \
    chsh -s /usr/bin/zsh psadi && \
    # --------------------------
    # NEOVIM
    # --------------------------
    mkdir -p /opt/pkg && chown psadi:psadi /opt/pkg && \
    axel --quiet https://github.com/neovim/neovim/releases/download/$(curl -L -s "https://api.github.com/repos/neovim/neovim/tags" | jq -r '.[0].name')/nvim-linux64.tar.gz --output=/opt/pkg && \
    tar -xzf /opt/pkg/nvim-linux64.tar.gz -C /opt/pkg && \
    touch /home/psadi/.hushlogin && \
    # --------------------------
    # ZELLIJ
    # --------------------------
    axel --quiet https://github.com/zellij-org/zellij/releases/download/$(curl -L -s "https://api.github.com/repos/zellij-org/zellij/tags" | jq -r '.[0].name')/zellij-x86_64-unknown-linux-musl.tar.gz --output=/opt/pkg && \
    tar -xzf /opt/pkg/zellij-x86_64-unknown-linux-musl.tar.gz -C /opt/pkg && \
    mv /opt/pkg/zellij /usr/local/bin/zellij && \
    chmod +x /usr/local/bin/zellij && \
    rm /opt/pkg/zellij-x86_64-unknown-linux-musl.tar.gz && \
    # --------------------------
    # EZA
    # --------------------------
    axel --quiet https://github.com/eza-community/eza/releases/download/$(curl -L -s "https://api.github.com/repos/eza-community/eza/tags" | jq -r '.[0].name')/eza_x86_64-unknown-linux-gnu.tar.gz --output=/opt/pkg && \
    tar -xzf /opt/pkg/eza_x86_64-unknown-linux-gnu.tar.gz -C /opt/pkg && \
    mv /opt/pkg/eza /usr/local/bin/eza && \
    chmod +x /usr/local/bin/eza && \
    rm /opt/pkg/eza_x86_64-unknown-linux-gnu.tar.gz && \
    # --------------------------
    # FZF
    # --------------------------
    axel --quiet https://github.com/junegunn/fzf/releases/download/$(curl -L -s "https://api.github.com/repos/junegunn/fzf/tags" | jq -r '.[0].name')/fzf-0.46.0-linux_amd64.tar.gz --output=/opt/pkg && \
    tar -xzf /opt/pkg/fzf-0.46.0-linux_amd64.tar.gz -C /opt/pkg && \
    mv /opt/pkg/fzf /usr/local/bin/fzf && \
    chmod +x /usr/local/bin/fzf && \
    rm /opt/pkg/fzf-0.46.0-linux_amd64.tar.gz && \
    # --------------------------
    # KUBECTL
    # --------------------------
    axel --quiet https://dl.k8s.io/release/$(curl -L -s "https://dl.k8s.io/release/stable.txt")/bin/linux/amd64/kubectl --output=/usr/local/bin && \
    chmod +x /usr/local/bin/kubectl && \
    # --------------------------
    # HELM
    # --------------------------
    curl -s https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash && \
    # --------------------------
    #  K9S
    # --------------------------
    axel --quiet https://github.com/derailed/k9s/releases/download/$(curl -L -s "https://api.github.com/repos/derailed/k9s/tags" | jq -r '.[0].name')/k9s_Linux_amd64.tar.gz --output=/opt/pkg && \
    tar -C /opt/pkg -zxf /opt/pkg/k9s_Linux_amd64.tar.gz k9s && \
    mv /opt/pkg/k9s /usr/local/bin/k9s && \
    chmod +x /usr/local/bin/k9s && \
    rm /opt/pkg/k9s_Linux_amd64.tar.gz && \
    # --------------------------
    # TERRAFORM
    # --------------------------
    tf_latest=$(curl -L -s "https://api.github.com/repos/hashicorp/terraform/tags" | jq -r '.[0].name' | sed -e 's/v//g') && \
    axel --quiet "https://releases.hashicorp.com/terraform/${tf_latest}/terraform_${tf_latest}_linux_amd64.zip" --output=/opt/pkg && \
    unzip -q "/opt/pkg/terraform_${tf_latest}_linux_amd64.zip" -d /usr/local/bin && \
    chmod +x /usr/local/bin/terraform && \
    rm "/opt/pkg/terraform_${tf_latest}_linux_amd64.zip" && \
    # --------------------------
    # FINALIZE & CLEANUP
    # --------------------------
    apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove --purge && \
    python3 -m pip cache purge && \
    rm -rf /var/log/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apt/archives/* && \
    rm -rf /opt/pkg/nvim-linux64.tar.gz && \
    rm /home/psadi/.profile && rm /home/psadi/.bash* && \
    chown -R root:root /usr/local/bin && \
    mv /tmp/dotfiles /home/psadi/dotfiles && \
    mkdir -p /home/psadi/.config && \
    ln -s /home/psadi/dotfiles/zsh/zshrc /home/psadi/.zshrc && \
    ln -s /home/psadi/dotfiles/git/.gitconfig /home/psadi/.gitconfig && \
    ln -s /home/psadi/dotfiles/zellij /home/psadi/.config/zellij && \
    chown -R psadi:psadi /home/psadi

WORKDIR /home/psadi

USER psadi

RUN git clone https://github.com/LazyVim/starter ~/.config/nvim && \
    /opt/pkg/nvim-linux64/bin/nvim -c "qa"

ENTRYPOINT ["/usr/bin/zsh"]

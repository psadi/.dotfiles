FROM debian:bookworm-slim as base

LABEL maintainer="psadi (ps.adithya@icloud.com)" \
    description="Docker image for my personal development environment"

# --------------------------
# SETUP
# --------------------------

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
    sudo python3-minimal python3-pip && \
    pip3 install ansible --break-system-packages --no-cache-dir --no-warn-script-location && \
    # --------------------------
    # CREATE & CONFIGURE USER
    # --------------------------
    useradd -m -s /usr/bin/zsh -G sudo -u 1000 -U psadi && \
    echo "psadi ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    usermod --password "${LINUX_USER_PASSWORD}" psadi

FROM base as builder

WORKDIR /home/psadi

USER psadi

COPY --chown=psadi:psadi . dotfiles

ENV ANSIBLE_CONFIG=/home/psadi/dotfiles/ansible/ansible.cfg \
    ANSIBLE_INVENTORY_WARNING=false

RUN ansible-playbook dotfiles/ansible/site.yaml

ENTRYPOINT ["/usr/bin/zsh"]

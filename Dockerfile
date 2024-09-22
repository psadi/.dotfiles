FROM debian:bookworm-slim as base

LABEL maintainer="psadi (ps.adithya@icloud.com)" \
    description="Docker image for my personal development environment"

ENV LANG=en_US.UTF-8
# --------------------------
# SETUP
# --------------------------

RUN apt-get update -y && apt-get upgrade -y && apt-get install --no-install-recommends -y \
    sudo python3-minimal python3-pip python3-venv locales && \
    pip3 install ansible pip --upgrade --break-system-packages --no-cache-dir --no-warn-script-location && \
    # --------------------------
    # CREATE & CONFIGURE USER
    # --------------------------
    useradd -m -s /usr/bin/zsh -G sudo -u 1000 -U psadi && \
    echo "psadi ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    usermod --password "${LINUX_USER_PASSWORD}" psadi && \
    # --------------------------
    # Configure Locale
    # --------------------------
    sed -i -e "s/# $LANG.*/$LANG UTF-8/" /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG="${LANG}"

FROM base as builder

WORKDIR /home/psadi

USER psadi

COPY --chown=psadi:psadi . .dotfiles

ENV ANSIBLE_CONFIG=/home/psadi/dotfiles/ansible/ansible.cfg \
    ANSIBLE_INVENTORY_WARNING=false

RUN ansible-playbook dotfiles/ansible/site.yaml --tags linux

ENTRYPOINT ["/usr/bin/zsh"]

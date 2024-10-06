# Dotfiles & Personal Development Environment (PDE) 🚀

<p align="center">
  <img src="https://raw.githubusercontent.com/psadi/dotfiles/main/assets/image.png" alt="alt text" width="200" height="200">
</p>

## Table of Contents

- [Introduction](#introduction)
- [Pre-requisites](#pre-requisites)
- [Installation](#installation)
- [Docker Environment](#docker-environment)
- [Disclaimer](#disclaimer)
- [License](#license)

## Introduction

This repository contains the configuration files for my personal development environment.

The idea is to have a single repository with all the configuration files for my development environment, so that I can easily set up a new machine with all the tools and configurations I need with the below principles in mind

- Reproducible
- Version Controlled
- Immutabe
- Secure
- Portable
- Scalabe
- Flexible
- Maintainable

## Pre-requisites

The following software must be installed on your system:

- [git](https://git-scm.com/)
- [python3](https://www.python.org/)
- [ansible](https://www.ansible.com/)
- [docker](https://www.docker.com/) or [podman](https://podman.io/) - To leverage the built image

## Installation

One Script Installer

```bash
curl -o- https://raw.githubusercontent.com/psadi/.dotfiles/refs/heads/main/bootstrap | bash
```

Manual Steps:

To install the configuration files, run the following commands:

```bash
git clone https://psadi/.dotfiles.git && cd dotfiles

export ANSIBLE_CONFIG="${HOME}/.dotfiles/ansible/ansible.cfg"
export ANSIBLE_INVENTORY_WARNING=False

# Remember vault password file at ansible/.vault_pass
export ANSIBLE_VAULT_PASSWORD_FILE="${HOME}/.dotfiles/ansible/.vault_pass"

ansible-playbook "${HOME}/.dotfiles/ansible/site.yaml" --tags "${OSTYPE}" --user "${USER}"
```

## Docker Environment

A docker image is available with all the tools and configurations pre-installed. To use the docker image, run the following commands:

```bash
docker run -it psadi/pde:latest
```

A shell [script](https://github.com/psadi/dotfiles/blob/main/.local/bin/devsh) is available to run the docker image with optional arguments to be passed during runtime.

**\*Pre-requisite:** dotfiles to be cloned to the home directory & configured as per the above instructions\*

To Invoke the script, run the following commands:

| INVOKE TYPE    | COMMAND                                    |
| -------------- | ------------------------------------------ |
| Standalone     | `devsh`                                    |
| With Arguments | `devsh -v ./path/to/volume:/path/to/mount` |

## Disclaimer

1. Though the configurations are tested on my personal machine, it is recommended to review the configurations before using them on your machine.
2. The configurations are provided as-is without any warranty and the author is not responsible for any damage caused by the use of these configurations.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE)

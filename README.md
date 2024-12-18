# Dotfiles & Personal Development Environment (PDE) 🚀

<p align="center">
  <img src="https://raw.githubusercontent.com/psadi/dotfiles/main/assets/image.png" alt="alt text" width="200" height="200">
</p>

## Table of Contents

- [Introduction](#introduction)
- [Installation](#installation)
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

## Installation

One Script Installer

```bash
/bin/bash -c "$(curl --proto '=https' --tlsv1.2 -LsSf https://raw.githubusercontent.com/psadi/.dotfiles/refs/heads/main/bootstrap)"
```

Shorterend Version

```bash
/bin/bash -c "$(curl --proto '=https' --tlsv1.2 -LsSf https://bit.ly/3NlTbaf)"
```

Manual Steps:

To install the configuration files, run the following commands:

```bash
git clone https://psadi/.dotfiles.git "${HOME}/.dotfiles" && cd "${HOME}/.dotfiles"

export ANSIBLE_CONFIG="${HOME}/.dotfiles/ansible/ansible.cfg"

ansible-playbook "${HOME}/.dotfiles/ansible/site.yaml" --tags "${OSTYPE}" --user "${USER}" --ask-become-pass
```

## Disclaimer

1. Though the configurations are tested on my personal machine, it is recommended to review the configurations before using them on your machine.
2. The configurations are provided as-is without any warranty and the author is not responsible for any damage caused by the use of these configurations.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE)

# Dotfiles & Personal Development Environment (PDE) 🚀

<p align="center">
  <img src="image.png" alt="alt text" width="150" height="150">
</p>

## Introduction

This repository contains the configuration files for my personal development environment.

## Pre-requisites

The following software must be installed on your system:

- [Git](https://git-scm.com/)
- [Python3](https://www.python.org/)
- [ansible](https://www.ansible.com/)

## Installation

To install the configuration files, run the following commands:

```bash
git clone https://psadi/dotfiles.git
cd dotfiles

export ANSIBLE_CONFIG=ansible/ansible.cfg
export ANSIBLE_INVENTORY_WARNING=False
export ANSIBLE_VAULT_PASSWORD_FILE=ansible/.vault_pass

# Remember vault password file at ansible/.vault_pass
ansible-playbook ansible/site.yaml
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE)

# Dotfiles & Personal Development Environment (PDE) 🚀

<p align="center">
  <img src="https://raw.githubusercontent.com/psadi/dotfiles/main/assets/image.png" alt="alt text" width="200" height="200">
</p>

## Table of Contents

- [Introduction](#introduction)
- [Pre-requisites](#pre-requisites)
- [Installation](#installation)
- [Docker Environment](#docker-environment)
- [Contributing Guidelines](#contributing-guidelines)
  - [How to Contribute](#how-to-contribute)
  - [Code Style](#code-style)
  - [Testing](#testing)
  - [Documentation](#documentation)
  - [Review Process](#review-process)
  - [Code of Conduct](#code-of-conduct)
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

- [Git](https://git-scm.com/)
- [Python3](https://www.python.org/)
- [ansible](https://www.ansible.com/)
- [docker](https://www.docker.com/) or [podman](https://podman.io/) - To leverage the built image

## Installation

To install the configuration files, run the following commands:

```bash
git clone https://psadi/dotfiles.git
cd dotfiles

export ANSIBLE_CONFIG="${PWD}/ansible/ansible.cfg"
export ANSIBLE_INVENTORY_WARNING=False

# Remember vault password file at ansible/.vault_pass
export ANSIBLE_VAULT_PASSWORD_FILE=ansible/.vault_pass

ansible-playbook ansible/site.yaml
```
## Docker Environment

A docker image is available with all the tools and configurations pre-installed. To use the docker image, run the following commands:

```bash
docker run -it psadi/pde:latest
```

A shell [script](https://github.com/psadi/dotfiles/blob/main/.local/bin/devsh) is available to run the docker image with optional arguments to be passed during runtime.

***Pre-requisite:** dotfiles to be cloned to the home directory & configured as per the above instructions*

To Invoke the script, run the following commands:

|INVOKE TYPE|COMMAND|
|---|---|
|Standalone|`devsh`|
|With Arguments|`devsh -v ./path/to/volume:/path/to/mount`|

---

## Contributing Guidelines

Thank you for considering contributing to this project! By participating in this open-source project, you agree to abide by the [code of conduct](CODE_OF_CONDUCT.md).

## How to Contribute

### Reporting Issues

If you encounter any issues or have suggestions for improvements, please check the existing issues to see if the topic has already been discussed. If not, feel free to open a new issue, providing as much detail as possible, including steps to reproduce the problem.

### Making Changes

If you'd like to contribute to the project:

1. Fork the repository to your GitHub account.
2. Create a new branch for your feature or bug fix.
3. Make your changes and ensure they are well-tested.
4. Commit your changes with clear and concise commit messages.
5. Push your branch to your fork.
6. Create a pull request against the `main` branch of this repository.

### Code Style

Follow the existing code style and formatting conventions in the project. If there's a specific style guide for a particular language or tool, adhere to it.

### Testing

Ensure that your changes are well-tested. If applicable, provide test cases to validate the correctness of your code.

### Documentation

Update the README.md file or any relevant documentation to reflect your changes. Clear and concise documentation is crucial for understanding the purpose and usage of your contribution.

### Review Process

All contributions will be reviewed before merging. Be open to feedback and be willing to make changes based on the feedback received.

## Code of Conduct

Please follow our [code of conduct](CODE_OF_CONDUCT.md) in all interactions, both within this project and in the larger open-source community.

## Disclaimer
Though the configurations are tested on my personal machine, it is recommended to review the configurations before using them on your machine. The configurations are provided as-is without any warranty and the author is not responsible for any damage caused by the use of these configurations.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE)

# .dotfiles 🚀 <img src="https://upload.wikimedia.org/wikipedia/commons/a/ab/Logo-ubuntu_cof-orange-hex.svg" alt="Canonical Ubuntu" width="35">

## Installation

#### One Script Installer:

```bash
/bin/bash -c "$(curl --proto '=https' --tlsv1.2 -LsSf https://raw.githubusercontent.com/psadi/.dotfiles/refs/heads/main/bootstrap)"
```

#### Shorterend Version:

```bash
/bin/bash -c "$(curl --proto '=https' --tlsv1.2 -LsSf https://bit.ly/3NlTbaf)"
```

#### Manual Steps:

To install the configuration files, run the following commands:

```bash
OSTYPE=$(uname -s | tr '[:upper:]' '[:lower:]')

git clone https://psadi/.dotfiles.git "${HOME}/.dotfiles" && cd "${HOME}/.dotfiles"

export ANSIBLE_CONFIG="${HOME}/.dotfiles/ansible/ansible.cfg"

ansible-playbook "${HOME}/.dotfiles/ansible/site.yaml" --tags "${OSTYPE}" --user "${USER}" --ask-become-pass
# Note: --ask-become-pass is your system sudo password
```

## Disclaimer

1. Though the configurations are tested on my personal machine, it is recommended to review the configurations before using them on your machine.
2. The configurations are provided as-is without any warranty and the author is not responsible for any damage caused by the use of these configurations.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE)

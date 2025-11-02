#!/usr/bin/env bash

REPO="$(pwd)"

banner() {
    clear
    echo " "
    echo "╔═══════════════════════════════════╗"
    echo "║        Termux Setup Script        ║"
    echo "╚═══════════════════════════════════╝"
    echo ""
    echo "do you want to continue(Y/n)"
    read -r value
    if [[ "$value" = "n" ]]; then
        echo "Aborting setup"
        exit 0
    elif [[ "$value" = "y" || "$value" = "Y" ]]
        echo "Starting setup..."
    else
        echo "Invalid input. Aborting."
        exit 1
    fi
}

# install essentinal package
Install_pkg() {
    echo "updating package"
    pkg update -y && pkg upgrade -y

    echo "Installing essential packages..."
    pkg install -y git curl wget vim nano htop zsh lazygit tmux python neovim
}

# Local bin in bash
Bash_bin() {
    "making sure your local bin has permission to do"
    mkdir -p ~/.local/bin
    echo 'export PATH="$HOME/.local/bin:$PATH"' >>~/.bashrc
    echo " Added ~/.local/bin to PATH in .bashrc"
    source ~/.bashrc
}

# Access to storage
Access_termux() {
    echo " Requesting storage access..."
    termux-setup-storage
    echo "Permission granted"
}

#do you wanna use zsh
Install_zsh() {
    # sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

Copy_file() {
    cp -r "$REPO/.tmux.conf" "$HOME/."
    cp -r "$REPO/.zshrc" "$HOME/."
    echo "copied tmux and zshrc "
}

Set_zsh() {
    if [ "$SHELL" != "$(command -v zsh)" ]; then
        echo "Setting zsh as default shell..."
        chsh -s "$(command -v zsh)" || echo " Unable to change shell (Termux may not support chsh)"
    fi
}

Main() {
    Install_pkg
    Access_termux
    Bash_bin
    Install_zsh
    Copy_file
    Set_zsh
}

Main

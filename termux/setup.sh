#!/usr/bin/env bash

REPO="$(pwd)"

banner() {
    clear
    echo ""
    echo "╔═══════════════════════════════════╗"
    echo "║        Termux Setup Script        ║"
    echo "╚═══════════════════════════════════╝"
    echo " "
    echo ""
    echo "do you want to continue(Y/n)"
    read -r value
    if [[ "$value" = "n" ]]; then
        echo "Aborting setup"
        exit 0
    elif [[ "$value" = "y" || "$value" = "Y" ]]; then
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
    pkg install -y git curl wget vim nano htop zsh lazygit tmux python neovim iproute2 fzf
}

# Local bin in bash
Bash_bin() {
    echo "making sure your local bin has permission to do"
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
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

Copy_file() {
    cp -r "$REPO/.tmux.conf" "$HOME/."
    cp -r "$REPO/.zshrc" "$HOME/."
    echo "copied tmux and zshrc "
}

Set_zsh() {
    echo "Setting Zsh as default shell for Termux..."
    # Termux doesn't support `chsh`, so we modify the startup behavior manually
    if ! grep -q "exec zsh" "$HOME/.bashrc"; then
        echo 'exec zsh' >>"$HOME/.bashrc"
        echo "Added 'exec zsh' to .bashrc — Zsh will now start automatically."
    fi
}

Plugin_zsh() {
    echo "Downloading Plugins for zsh "
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-completions.git \
        ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
}

Main() {
    banner
    Install_pkg
    Access_termux
    Bash_bin
    Install_zsh
    Copy_file
    Set_zsh
    Plugin_zsh
}

Main

#!/usr/bin/env bash
# Devlopment tool kit
# Install all the essential

# Install package
PACKAGES=(cmake
    picom
    rofi
    wezterm
    alacritty
    zsh
    btop
    dunst
    git
    curl
    wget
    tmux
    bat
    unzip)

# Detect os
detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID"
    else
        echo "unknown"
    fi
}

install_packages() {
    distro=$(detect_distro)
    echo "==> Detected distro: $distro"
    case "$distro" in
    arch | manjaro | endeavouros)
        sudo pacman -Syu --needed --noconfirm "${PACKAGES[@]}"
        ;;
    debian | ubuntu | linuxmint)
        sudo apt update && sudo apt install -y "${PACKAGES[@]}"
        ;;
    fedora)
        sudo dnf install -y "${PACKAGES[@]}"
        ;;
    opensuse* | suse)
        sudo zypper install -y "${PACKAGES[@]}"
        ;;
    *)
        echo "⚠️ Unsupported distro: $distro"
        echo "Please install these packages manually: ${PACKAGES[*]}"
        ;;
    esac
}

Install_fzf() {
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
}

Install_neovim() {
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
    chmod u+x nvim-linux-x86_64.appimage

    mkdir -p /opt/nvim
    sudo mv nvim-linux-x86_64.appimage /opt/nvim/nvim
}

Install_starship() {
    curl -sS https://starship.rs/install.sh | sh
}

Install_font() {
    mkdir -p ~/.local/share/fonts

    wget -O JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
    unzip JetBrainsMono.zip -d ~/.local/share/fonts
    fc-cache -fv

}

Install_font1() {

    mkdir -p ~/.local/share/fonts

    wget -O Terminus.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Terminus.zip
    unzip Terminus.zip -d ~/.local/share/fonts
    fc-cache -fv
}

Install_fastfetch() {
    (
        git clone https://github.com/fastfetch-cli/fastfetch.git
        cd fastfetch || exit
        mkdir -p build
        cd build || exit
        cmake ..
        cmake --build . --target fastfetch
    )
}

Install_nvimconf() {
    mkdir -p "$HOME/.config/nvim"
    git clone https://github.com/hellopradeep69/Hello-Nvim.git "$HOME/.config/nvim"
    rm -rf "$HOME/.config/nvim/.git" "$HOME/.config/nvim/README.md"
}

Install_zen() {
    wget https://github.com/zen-browser/desktop/releases/latest/download/zen.linux-x86_64.tar.xz
    sudo mkdir -p /opt/zen
    sudo tar -xf zen.linux-x86_64.tar.xz -C /opt/zen
    sudo chmod +x /opt/zen/zen
    sudo ln -s /opt/zen/zen /usr/local/bin/zen
}

Plugin_zsh() {
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-completions.git \
        ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
}

# Install packages
echo "Installing necessary packages..."
install_packages
echo "Packages installed!"

# Install fzf
echo "Installing Fzf..."
Install_fzf

#Installing nvim
echo "Installing Neovim..."
Install_neovim

# Installing starship
echo "Installing starship..."
Install_starship

# Install font
echo "Installing Fonts"
Install_font
echo "....."
Install_font1

# Install fastfetch
echo "Installing fastfetch"
Install_fastfetch

# Install neovim config
echo " Install neovim config "
Install_nvimconf

echo "Install zsh plugin"
Plugin_zsh

echo " Setup complete! "

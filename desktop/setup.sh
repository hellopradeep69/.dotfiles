#!/usr/bin/env bash
# Devlopment tool kit
# Install all the essential

set -e

# Install package
Install_pack() {
    sudo apt update -y && sudo apt -y upgrade
    sudo apt install -y cmake picom rofi wezterm alacritty zsh btop dunst git curl wget tmux bat unzip trash
}

Install_fzf() {
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
}

Install_grep() {
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep_14.1.1-1_amd64.deb
    sudo dpkg -i ripgrep_14.1.1-1_amd64.deb
}

Install_neovim() {
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
    chmod u+x nvim-linux-x86_64.appimage

    mkdir -p /opt/nvim
    sudo mv nvim-linux-x86_64.appimage /opt/nvim/nvim
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
    rm JetBrainsMono.zip Terminus.zip
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
    git clone https://github.com/hellopradeep69/nvim.git "$HOME/.config/nvim"
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

Bat_install() {
    mkdir -p "$HOME"/.local/bin
    ln -s /usr/bin/batcat "$HOME"/.local/bin/bat
}

Fd_install() {
    ln -s $(which fdfind) "$HOME"/.local/bin/fd
}

# Install packages
echo "Installing necessary packages..."
Install_pack
echo "Packages installed"

# Install fzf
echo "Installing Fzf..."
Install_fzf
echo "Installed Fzf..."

# Install grep idk
echo "Installing grep..."
Install_grep
echo "Installed grep..."

#Installing nvim
echo "Installing Neovim..."
Install_neovim
echo "Installed Neovim..."

echo "Install bat"
Bat_install
echo "Installed bat"

echo "Install fd"
Fd_install
echo "Installed fd"

# Install font
echo "Installing Fonts"
Install_font
echo "....."
Install_font1
echo "Installed Fonts"

# Install fastfetch
echo "Installing fastfetch"
Install_fastfetch
echo "Installed fastfetch"
sudo cp fastfetch /usr/local/bin/

# Install neovim config
echo " Install neovim config "
Install_nvimconf
echo " Installed neovim config "

echo "Install zsh plugin"
Plugin_zsh
echo "Installed zsh plugin"

echo " Setup complete! "

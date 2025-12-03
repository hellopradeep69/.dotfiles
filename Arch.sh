#!/bin/bash
# My development setup for linux Arch

Install_pack(){
    sudo pacman -Syu
    sudo pacman -S --noconfirm fastfetch ghostty fd ripgrep tmux zsh btop curl wget trash-cli gcc
}

Install_font(){
    sudo pacman -S --noconfirm ttf-jetbrains-mono-nerd ttf-terminus-nerd ttf-jetbrains-mono
    fc-cache -f -v
}

Install_zplugin(){

# Create the directory if missing
mkdir -p ~/.oh-my-zsh/custom/plugins

# Install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-completions \
  ~/.oh-my-zsh/custom/plugins/zsh-completions
}

Zsh_setup(){
    Shell=$(echo "$SHELL")
    if [[ $Shell == "/usr/bin/zsh" ]]; then
        echo "zsh"
    else
        echo "not zsh"
        chsh -s  $(which zsh)
    fi

    if [[  -d  "$HOME/.oh-my-zsh" ]]; then
        echo "zsh available not touching"
    else
        echo "Downloading oh my zsh"
        # sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        Install_zplugin
    fi

    trash $HOME/.zshrc
    cp -r $HOME/dev/.zshrc $HOME/.zshrc

}

Nvim_setup(){
    rm -rf ~/.config/nvim
    mkdir -p ~/.config/nvim
    git clone https://github.com/hellopradeep69/nvim.git ~/.config/nvim/
    rm -rf ~/.config/nvim/.git
    rm -rf ~/.config/nvim/README.md
}

Ghostty_setup(){
    echo "Resetting ghostty config" 
    rm -rf ~/.config/ghostty
    mkdir -p ~/.config/ghostty
    cp -r $HOME/dev/resource/ghostty/config ~/.config/ghostty/
}

Install_sway(){
    sudo pacman -Syu
    sudo pacman -S sway swaylock i3status rofi-wayland brightnessctl mako wl-clipboard cliphist
}

# Ghostty_setup
# Install_font
Install_pack
Install_sway
# Nvim_setup
# Zsh_setup

